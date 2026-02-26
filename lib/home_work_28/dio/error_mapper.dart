import 'package:dio/dio.dart';

String mapDioErrorToUserMessage(DioException e) {
  // 1) Нет сети / не удалось подключиться
  // В Dio 5 это часто: connectionError, unknown (с SocketException внутри), timeout
  if (e.type == DioExceptionType.connectionError) {
    return 'Нет соединения с интернетом. Проверьте сеть.';
  }
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return 'Превышено время ожидания. Попробуйте ещё раз.';
  }

  // 2) HTTP ошибки (сервер ответил кодом)
  final status = e.response?.statusCode;
  if (status != null) {
    if (status == 400) return 'Неверный запрос (400). Проверьте данные.';
    if (status == 401) return 'Не авторизован (401). Войдите заново.';
    if (status >= 500) return 'Ошибка сервера ($status). Попробуйте позже.';
    return 'Ошибка ($status).';
  }

  // 3) Отмена запроса
  if (e.type == DioExceptionType.cancel) {
    return 'Запрос отменён.';
  }

  return 'Неизвестная ошибка сети.';
}
