import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/features/payment/data/models/paymob_models/invoice_link_generation_model.dart';
import 'package:payment/features/payment/data/models/paymob_models/invoice_token_model.dart';
import 'package:payment/features/payment/data/models/stripe_models/cutomer_input_model.dart';
import 'package:payment/features/payment/data/models/stripe_models/cutomer_model.dart';
import 'package:payment/features/payment/data/models/stripe_models/ephemeral_model.dart';
import 'package:payment/features/payment/data/models/stripe_models/payment_intent_input_model.dart';
import 'package:payment/features/payment/data/models/stripe_models/payment_intent_response_model.dart';
import 'package:payment/features/payment/data/repos/paymob_repo/paymob_repo.dart';
import 'package:payment/features/payment/data/repos/stripe_repo/stripe_repo.dart';
import 'package:payment/features/payment/presentation/cubits/payments_cubit/payment_state.dart';

class PaymentsCubit extends Cubit<PaymentState> {
  PaymentsCubit({
    required this.paymobRepo,
    required this.stripeRepo,
  }) : super(PaymentInitial());

  final PaymobRepo paymobRepo;
  final StripeRepo stripeRepo;

  // ---------------------- PAYMOB METHODS ----------------------
  Future<InvoiceTokenModel?> _getInvoiceToken() async {
    final result = await paymobRepo.getInvoiceToken();
    return result.fold(
      ifLeft: (failure) {
        emit(PaymentErrorState(error: failure.errorMessage));
        return null;
      },
      ifRight: (invoiceToken) {
        emit(PaymentSuccessState());
        return invoiceToken;
      },
    );
  }

  Future<InvoiceLinkGenerationModel?> payWithPaymob(
      {required num amount}) async {
    final tokenModel = await _getInvoiceToken();
    if (tokenModel?.token == null) {
      emit(PaymentErrorState(error: "Failed to retrieve invoice token"));
      return null;
    }

    final result = await paymobRepo.getInvoiceLink(
      amount: amount,
      token: tokenModel!.token!,
    );

    return result.fold(
      ifLeft: (failure) {
        emit(PaymentErrorState(error: failure.errorMessage));
        return null;
      },
      ifRight: (invoiceLink) {
        emit(PaymentSuccessState());
        return invoiceLink;
      },
    );
  }

  // ---------------------- STRIPE METHODS ----------------------
  Future<CustomerModel?> _createCustomer(
      {required CustomerInputModel inputModel}) async {
    final result =
        await stripeRepo.createCustomer(customerInputModel: inputModel);
    return result.fold(
      ifLeft: (failure) {
        emit(PaymentErrorState(error: failure.errorMessage));
        return null;
      },
      ifRight: (customer) {
        emit(PaymentSuccessState());
        return customer;
      },
    );
  }

  /// Creates (or retrieves) the customer.
  /// This should ideally be done once during user registration.
  Future<CustomerModel?> getCustomerModel() async {
    return _createCustomer(
      inputModel: CustomerInputModel(
        name: "Osama Mahmoud",
        email: "o@gmail.com",
        phone: "+20123456789",
      ),
    );
  }

  Future<EphemeralModel?> _createEphemeralKey(CustomerModel customer) async {
    final result = await stripeRepo.createEphemeralKey(customerModel: customer);
    return result.fold(
      ifLeft: (failure) {
        emit(PaymentErrorState(error: failure.errorMessage));
        return null;
      },
      ifRight: (ephemeralModel) {
        emit(PaymentSuccessState());
        return ephemeralModel;
      },
    );
  }

  Future<PaymentIntentResponseModel?> _createPaymentIntent(
    PaymentIntentInputModel inputModel,
  ) async {
    final result = await stripeRepo.createPaymentIntent(
        paymentIntentInputModel: inputModel);
    return result.fold(
      ifLeft: (failure) {
        emit(PaymentErrorState(error: failure.errorMessage));
        return null;
      },
      ifRight: (paymentIntentResponse) {
        emit(PaymentSuccessState());
        return paymentIntentResponse;
      },
    );
  }

  Future<void> _initPaymentSheet({
    required PaymentIntentInputModel paymentIntentInputModel,
    required PaymentIntentResponseModel paymentIntentResponseModel,
    required EphemeralModel ephemeralModel,
  }) async {
    final result = await stripeRepo.initPaymentSheet(
      paymentIntentInputModel: paymentIntentInputModel,
      paymentIntentResponseModel: paymentIntentResponseModel,
      ephemeralModel: ephemeralModel,
    );

    result.fold(
      ifLeft: (failure) => emit(PaymentErrorState(error: failure.errorMessage)),
      ifRight: (_) => emit(PaymentSuccessState()),
    );
  }

  Future<void> payWithStripe({required num amount}) async {
    // 1. Create (or retrieve) the customer.
    final dynamicCustomer = await getCustomerModel();
    if (dynamicCustomer == null) {
      emit(PaymentErrorState(error: "Customer creation failed"));
      return;
    }

    // For testing, we force a static customer id value.
    // In production, use the dynamic id: dynamicCustomer.id
    const staticCustomerId = "cus_S0LaX7JXOtK3Ta";

    // 2. Create the ephemeral key using the static customer id.
    // Note: We are creating a new CustomerModel with the static id.
    final ephemeralModel =
        await _createEphemeralKey(CustomerModel(id: staticCustomerId));
    if (ephemeralModel == null) {
      emit(PaymentErrorState(error: "Ephemeral key creation failed"));
      return;
    }

    // 3. Create the payment intent using the static customer id.
    final paymentIntentInputModel = PaymentIntentInputModel(
      amount: amount,
      currency: 'usd',
      customer:
          staticCustomerId, // Static value; in production, use dynamicCustomer.id
    );

    final paymentIntentResponse =
        await _createPaymentIntent(paymentIntentInputModel);
    if (paymentIntentResponse == null) {
      emit(PaymentErrorState(error: "Payment Intent creation failed"));
      return;
    }

    // 4. Initialize the payment sheet with the required parameters.
    await _initPaymentSheet(
      paymentIntentInputModel: paymentIntentInputModel,
      paymentIntentResponseModel: paymentIntentResponse,
      ephemeralModel: ephemeralModel,
    );
  }
}
