import 'package:dio/dio.dart';
import 'package:glint/services/api/api_config.dart';
import 'package:glint/services/api/auth_interceptor.dart';
import 'package:glint/services/api/token_storage.dart';

Dio createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      contentType: 'application/json',
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(TokenStorage()),
    LogInterceptor(requestBody: true, responseBody: true),
  ]);
  return dio;
}








