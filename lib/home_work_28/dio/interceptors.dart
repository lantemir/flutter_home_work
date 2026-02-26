import 'package:dio/dio.dart';

class LogInterceptorSimple extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Лог запроса
    // В реальном проекте лучше использовать logger пакет и скрывать токены.
    // ignore: avoid_print
    print('[DIO] → ${options.method} ${options.baseUrl}${options.path}');
    // ignore: avoid_print
    print('[DIO] headers: ${options.headers}');
    // ignore: avoid_print
    print('[DIO] query: ${options.queryParameters}');
    // ignore: avoid_print
    print('[DIO] data: ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ignore: avoid_print
    print('[DIO] ← ${response.statusCode} ${response.requestOptions.uri}');
    // ignore: avoid_print
    print('[DIO] data: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // ignore: avoid_print
    print('[DIO] ✕ ${err.type} ${err.requestOptions.uri}');
    // ignore: avoid_print
    print('[DIO] message: ${err.message}');
    handler.next(err);
  }
}
