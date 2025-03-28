import 'package:dart_either/dart_either.dart';

import '../../../../../core/networking/api_error_handler.dart';
import '../../models/paymob_models/invoice_link_generation_model.dart';
import '../../models/paymob_models/invoice_token_model.dart';

abstract class PaymobRepo {
  Future<Either<Failure, InvoiceTokenModel>> getInvoiceToken();
  Future<Either<Failure, InvoiceLinkGenerationModel>> getInvoiceLink(
      {required String token, required num amount});
}
