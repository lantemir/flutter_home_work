import 'package:dio/dio.dart';
import 'interceptors.dart';
import 'retry.dart';

Dio createDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 8),
      receiveTimeout: const Duration(seconds: 8),
      sendTimeout: const Duration(seconds: 8),
      headers: {'Accept': 'application/json'},
    ),
  );

  dio.interceptors.add(LogInterceptorSimple());

  // optional retry
  dio.interceptors.add(RetryInterceptor(dio: dio, retries: 2));

  return dio;
}
