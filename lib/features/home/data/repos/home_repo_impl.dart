import 'package:dart_either/src/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:payment/core/networking/api_constants.dart';
import 'package:payment/core/networking/api_error_handler.dart';
import 'package:payment/core/networking/api_service.dart';
import 'package:payment/features/home/data/models/products_model.dart';

import 'home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final ApiService apiService;

  HomeRepoImpl({required this.apiService});

  @override
  @override
  Future<Either<Failure, List<Products>>> getProducts() async {
    try {
      final response = await apiService.get(
          baseUrl: ApiConstants.productsBaseUrl,
          endpoint: ApiConstants.products);
      return Right(ProductsModel.fromJson(response).products!);
    } on DioException catch (dioError) {
      return Left(ServerFailure.fromDioError(dioError));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
