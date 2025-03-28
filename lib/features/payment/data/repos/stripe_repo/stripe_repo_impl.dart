import 'package:dart_either/dart_either.dart';
import 'package:dart_either/src/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/core/networking/api_constants.dart';
import 'package:payment/core/networking/api_error_handler.dart';
import 'package:payment/features/payment/data/models/stripe_models/cutomer_input_model.dart';
import 'package:payment/features/payment/data/models/stripe_models/cutomer_model.dart';
import 'package:payment/features/payment/data/models/stripe_models/ephemeral_model.dart';
import 'package:payment/features/payment/data/models/stripe_models/payment_intent_input_model.dart';
import 'package:payment/features/payment/data/models/stripe_models/payment_intent_response_model.dart';
import 'package:payment/features/payment/data/repos/stripe_repo/stripe_repo.dart';

import '../../../../../core/networking/api_service.dart';

class StripeRepoImpl extends StripeRepo {
  final ApiService apiService;

  StripeRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, CustomerModel>> createCustomer(
      {required CustomerInputModel customerInputModel}) async {
    try {
      final response = await apiService.post(
        baseUrl: ApiConstants.stripeBaseUrl,
        endpoint: ApiConstants.stripeCreateCustomer,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${ApiConstants.stripeSecretKey}",
        },
        data: customerInputModel.toMap(),
      );
      CustomerModel customerModel = CustomerModel.fromJson(response);
      return Right(customerModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, EphemeralModel>> createEphemeralKey(
      {required CustomerModel customerModel}) async {
    try {
      final response = await apiService.post(
        baseUrl: ApiConstants.stripeBaseUrl,
        endpoint: ApiConstants.stripeCreateEphemeralKey,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${ApiConstants.stripeSecretKey}",
          "Stripe-Version": "2025-02-24.acacia",
        },
        data: {
          "customer": customerModel.id,
        },
      );
      EphemeralModel ephemeralModel = EphemeralModel.fromJson(response);
      return Right(ephemeralModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaymentIntentResponseModel>> createPaymentIntent({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    try {
      final response = await apiService.post(
        baseUrl: ApiConstants.stripeBaseUrl,
        endpoint: ApiConstants.stripeCreatePaymentIntent,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Bearer ${ApiConstants.stripeSecretKey}",
        },
        data: PaymentIntentInputModel(
          amount: (paymentIntentInputModel.amount * 100).toInt(),
          currency: paymentIntentInputModel.currency,
          customer: paymentIntentInputModel.customer,
        ).toJson(),
      );
      PaymentIntentResponseModel paymentIntentResponseModel =
          PaymentIntentResponseModel.fromJson(response);
      return Right(paymentIntentResponseModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> initPaymentSheet({
    required PaymentIntentInputModel paymentIntentInputModel,
    required PaymentIntentResponseModel paymentIntentResponseModel,
    required EphemeralModel ephemeralModel,
  }) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Osama Test Merchant No. 1',
          allowsDelayedPaymentMethods: true,
          paymentIntentClientSecret: paymentIntentResponseModel.clientSecret,
          customerEphemeralKeySecret: ephemeralModel.secret,
          customerId: paymentIntentInputModel.customer,
          applePay: const PaymentSheetApplePay(
            merchantCountryCode: 'US',
          ),
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            testEnv: true,
          ),
        ),
      );
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
