import 'package:dio/dio.dart';

class PreviewAuctionErrorEntity {
  final String message;
  final int? code;
  final String? type;

  const PreviewAuctionErrorEntity({
    required this.message,
    this.code,
    this.type,
  });
}

class PreviewAuctionErrorHandler {
  static PreviewAuctionErrorEntity handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is String) {
      return PreviewAuctionErrorEntity(message: error);
    } else {
      return PreviewAuctionErrorEntity(
        message: error?.toString() ?? 'Unknown error occurred',
      );
    }
  }

  static PreviewAuctionErrorEntity _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const PreviewAuctionErrorEntity(
          message: 'Connection timeout. Please check your internet connection.',
          type: 'CONNECTION_TIMEOUT',
        );
      case DioExceptionType.sendTimeout:
        return const PreviewAuctionErrorEntity(
          message: 'Request timeout. Please try again.',
          type: 'SEND_TIMEOUT',
        );
      case DioExceptionType.receiveTimeout:
        return const PreviewAuctionErrorEntity(
          message: 'Response timeout. Please try again.',
          type: 'RECEIVE_TIMEOUT',
        );
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
      case DioExceptionType.cancel:
        return const PreviewAuctionErrorEntity(
          message: 'Request was cancelled.',
          type: 'CANCELLED',
        );
      case DioExceptionType.unknown:
        return const PreviewAuctionErrorEntity(
          message: 'Network error. Please check your connection.',
          type: 'NETWORK_ERROR',
        );
      default:
        return PreviewAuctionErrorEntity(
          message: error.message ?? 'Unknown error occurred',
        );
    }
  }

  static PreviewAuctionErrorEntity _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    String message = 'Server error occurred';

    if (data is Map<String, dynamic> && data.containsKey('message')) {
      message = data['message'].toString();
    }

    switch (statusCode) {
      case 400:
        return PreviewAuctionErrorEntity(
          message: message.isNotEmpty ? message : 'Bad request',
          code: 400,
          type: 'BAD_REQUEST',
        );
      case 401:
        return PreviewAuctionErrorEntity(
          message: message.isNotEmpty ? message : 'Unauthorized access',
          code: 401,
          type: 'UNAUTHORIZED',
        );
      case 403:
        return PreviewAuctionErrorEntity(
          message: message.isNotEmpty ? message : 'Access forbidden',
          code: 403,
          type: 'FORBIDDEN',
        );
      case 404:
        return PreviewAuctionErrorEntity(
          message: message.isNotEmpty ? message : 'Resource not found',
          code: 404,
          type: 'NOT_FOUND',
        );
      case 422:
        return PreviewAuctionErrorEntity(
          message: message.isNotEmpty ? message : 'Validation error',
          code: 422,
          type: 'VALIDATION_ERROR',
        );
      case 500:
        return PreviewAuctionErrorEntity(
          message: message.isNotEmpty ? message : 'Internal server error',
          code: 500,
          type: 'SERVER_ERROR',
        );
      default:
        return PreviewAuctionErrorEntity(
          message: message.isNotEmpty ? message : 'Server error occurred',
          code: statusCode,
          type: 'SERVER_ERROR',
        );
    }
  }
}
