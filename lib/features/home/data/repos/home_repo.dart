import 'package:dart_either/dart_either.dart';
import 'package:payment/features/home/data/models/products_model.dart';

import '../../../../core/networking/api_error_handler.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<Products>>> getProducts();
}
