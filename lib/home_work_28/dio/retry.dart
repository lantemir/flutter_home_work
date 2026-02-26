import 'dart:async';
import 'package:dio/dio.dart';

bool _isRetryable(DioException e) {
  // retry только на сетевые ошибки/таймауты, НЕ на 400/401/500
  return e.type == DioExceptionType.connectionError ||
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout;
}

class RetryInterceptor extends Interceptor {
  RetryInterceptor({required this.dio, this.retries = 2});

  final Dio dio;
  final int retries;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;

    final attempt = (requestOptions.extra['retry_attempt'] as int?) ?? 0;

    if (attempt < retries && _isRetryable(err)) {
      requestOptions.extra['retry_attempt'] = attempt + 1;

      // простая задержка между попытками
      await Future<void>.delayed(Duration(milliseconds: 300 * (attempt + 1)));

      try {
        final response = await dio.fetch(requestOptions);
        return handler.resolve(response);
      } catch (e) {
        // если снова упало — отдаём дальше
        return handler.next(err);
      }
    }

    return handler.next(err);
  }
}
