import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app_config/app_config.dart';
import '../../shared/blocs/main_app_bloc.dart';
import '../cache/shared_helper.dart';

enum ServerMethods { GET, POST, UPDATE, DELETE, PUT, PATCH, DOWNLOAD }

class Network {
  // Private instance for singleton behavior
  static final Network _instance = Network._internal();

  // Dio instance
  final Dio _dio;

  // Private constructor
  Network._internal()
      : _dio = Dio(BaseOptions(
          baseUrl: AppConfig.BASE_URL,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
        )) {
    _configureInterceptors();
  }

  // Factory constructor to return the same instance
  factory Network() => _instance;

  // Interceptor configuration
  void _configureInterceptors() {
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: true,
        error: true,
        maxWidth: 120,
      ));
    }
    _dio.interceptors.add(DioCacheInterceptor(
      options: CacheOptions(
        store: MemCacheStore(),
        policy: CachePolicy.request,
        hitCacheOnErrorExcept: [401, 403],
        maxStale: const Duration(days: 5),
        priority: CachePriority.high,
        cipher: null,
        // keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        allowPostMethod: false,
      ),
    ));
  }

  static Future<Map<String, dynamic>> _getHeaders() async {
    String? token = SharedHelper.sharedHelper?.getToken();

    return {
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Authorization': token != null ? 'Bearer $token' : '',
      'lang': mainAppBloc.globalLang,
      // 'Accept-Language': mainAppBloc.globalLang,
    };
  }

  // Request method
  Future<Response> request(
    String endpoint, {
    required ServerMethods method,
    final Object? body,
    final Map<String, dynamic>? queryParameters,
    final Map<String, String>? headers,
    final String? downloadPath,
    Function(int recived, int total)? onProgress,
    final String? baseUrl,
    final Duration? timoutDuration,
    final bool removeToken = false,
    final String? tempToken,
  }) async {
    Response response;
    _dio.options.headers = headers ?? await _getHeaders();
    if (baseUrl != null) {
      _dio.options.baseUrl = baseUrl;
    }
    if (timoutDuration != null) {
      _dio.options.sendTimeout = timoutDuration;
      _dio.options.receiveTimeout = timoutDuration;
      _dio.options.connectTimeout = timoutDuration;
    }
    if (removeToken) {
      _removeTokenFromHeader();
    }
    if (tempToken != null && tempToken.isNotEmpty) {
      _addTempTokenToHeader(tempToken);
    }

    switch (method) {
      case ServerMethods.GET:
        response = await _dio.get(endpoint, queryParameters: queryParameters);
        break;
      case ServerMethods.POST:
        response = await _dio.post(
          endpoint,
          data: body,
          queryParameters: queryParameters,
        );
        break;
      case ServerMethods.UPDATE:
        response = await _dio.patch(
          endpoint,
          data: body,
          queryParameters: queryParameters,
        );
        break;
      case ServerMethods.PUT:
        response = await _dio.put(
          endpoint,
          data: body,
          queryParameters: queryParameters,
        );
        break;
      case ServerMethods.PATCH:
        response = await _dio.patch(
          endpoint,
          data: body,
          queryParameters: queryParameters,
        );
        break;
      case ServerMethods.DELETE:
        response = await _dio.delete(
          endpoint,
          data: body,
          queryParameters: queryParameters,
        );
        break;
      case ServerMethods.DOWNLOAD:
        if (downloadPath == null) {
          throw ArgumentError(
              'Download path cannot be null for DOWNLOAD method');
        }
        response = await _dio.download(
          endpoint,
          downloadPath,
          onReceiveProgress: onProgress,
        );
        break;
    }

    return response;
  }

  void _removeTokenFromHeader() {
    _dio.options.headers.remove('Authorization');
  }

  void _addTempTokenToHeader(String tempToken) {
    _removeTokenFromHeader();
    _dio.options.headers.addAll({'Authorization': 'Bearer $tempToken'});
  }
}
