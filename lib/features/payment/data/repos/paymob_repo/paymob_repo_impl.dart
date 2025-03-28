import 'package:dart_either/src/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:payment/core/networking/api_constants.dart';
import 'package:payment/core/networking/api_error_handler.dart';
import 'package:payment/core/networking/api_service.dart';
import 'package:payment/features/payment/data/repos/paymob_repo/paymob_repo.dart';

import '../../models/paymob_models/invoice_link_generation_input_model.dart';
import '../../models/paymob_models/invoice_link_generation_model.dart';
import '../../models/paymob_models/invoice_token_model.dart';

class PaymobRepoImpl extends PaymobRepo {
  final ApiService apiService;

  PaymobRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, InvoiceTokenModel>> getInvoiceToken() async {
    try {
      final result = await apiService.post(
        baseUrl: ApiConstants.paymobBaseUrl,
        endpoint: ApiConstants.paymobToken,
        data: {
          "api_key": ApiConstants.paymobApiKey,
        },
      );
      return Right(InvoiceTokenModel.fromJson(result));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, InvoiceLinkGenerationModel>> getInvoiceLink(
      {required String token, required num amount}) async {
    try {
      final result = await apiService.post(
        baseUrl: ApiConstants.paymobBaseUrl,
        endpoint: ApiConstants.paymobInvoice,
        data: InvoiceLinkGenerationInputModel(
          authToken: token,
          amountCents: (amount * 100).toInt().toString(),
          currency: "EGP",
          apiSource: "INVOICE",
          integrations: ApiConstants.paymobIntegrations,
          shippingData: ShippingInputData(
            firstName: "Test",
            lastName: "Account",
            email: "lWV4F@example.com",
            phoneNumber: "0123456789",
          ),
        ).toJson(),
      );
      return Right(InvoiceLinkGenerationModel.fromJson(result));
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
