import 'package:dio/dio.dart';

sealed class Failure {
  final String errorMessage;
  Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errorMessage:
              'The connection took too long. Please check your internet connection and try again.',
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          errorMessage: 'The request is taking too long. Please try again.',
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          errorMessage:
              'The server is not responding in time. Please try again later.',
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          errorMessage:
              'There is a security issue with the server. Please try again later.',
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.data,
          dioError.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          errorMessage: 'Your request was cancelled. Please try again.',
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          errorMessage:
              'Unable to connect to the server. Please check your connection and try again.',
        );
      case DioExceptionType.unknown:
        if (dioError.message != null &&
            dioError.message!.contains('SocketException')) {
          return ServerFailure(
            errorMessage:
                'No internet connection. Please check your network settings.',
          );
        }
        return ServerFailure(
          errorMessage: 'An unexpected error occurred. Please try again.',
        );
    }
  }

  factory ServerFailure.fromResponse(dynamic json, int? code) {
    switch (code) {
      case 400:
        return ServerFailure(
          errorMessage: 'Bad request. Please try again.',
        );
      case 401:
        return ServerFailure(
          errorMessage: 'You are not authorized to access this data.',
        );
      case 404:
        return ServerFailure(
          errorMessage: 'Requested resource not found.',
        );
      case 409:
        return ServerFailure(
          errorMessage: 'There is a conflict with your request.',
        );
      case 422:
        return ServerFailure(
          errorMessage:
              'Unable to process the request. Please check your input and try again.',
        );
      case 500:
        return ServerFailure(
          errorMessage: 'Internal server error. Please try again later.',
        );
      default:
        return ServerFailure(
          errorMessage: 'An unexpected error occurred. Please try again.',
        );
    }
  }
}
