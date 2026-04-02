class ErrorHandler {
  static String map(Object error) {
    final text = error.toString();

    if (text.contains('empty')) {
      return 'Введите название задачи.';
    }

    if (text.contains('Failed to load tasks')) {
      return 'Не удалось загрузить задачи.';
    }

    return 'Произошла ошибка. Повторите попытку.';
  }
}
