import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});

  Future<Map<String, dynamic>> get({
    required String baseUrl,
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await dio.get(baseUrl + endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ));
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String baseUrl,
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    final response = await dio.post(
      baseUrl + endpoint,
      queryParameters: queryParameters,
      data: data,
      options: Options(
        headers: headers,
      ),
    );
    return response.data;
  }
}
