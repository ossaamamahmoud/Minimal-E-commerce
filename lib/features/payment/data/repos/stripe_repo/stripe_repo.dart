import 'package:dart_either/dart_either.dart';
import 'package:payment/features/payment/data/models/stripe_models/payment_intent_response_model.dart';

import '../../../../../core/networking/api_error_handler.dart';
import '../../models/stripe_models/cutomer_input_model.dart';
import '../../models/stripe_models/cutomer_model.dart';
import '../../models/stripe_models/ephemeral_model.dart';
import '../../models/stripe_models/payment_intent_input_model.dart';

abstract class StripeRepo {
  Future<Either<Failure, PaymentIntentResponseModel>> createPaymentIntent({
    required PaymentIntentInputModel paymentIntentInputModel,
  });

  Future<Either<Failure, CustomerModel>> createCustomer(
      {required CustomerInputModel customerInputModel});

  Future<Either<Failure, EphemeralModel>> createEphemeralKey({
    required CustomerModel customerModel,
  });

  Future<Either<Failure, void>> initPaymentSheet({
    required PaymentIntentInputModel paymentIntentInputModel,
    required PaymentIntentResponseModel paymentIntentResponseModel,
    required EphemeralModel ephemeralModel,
  });
}
