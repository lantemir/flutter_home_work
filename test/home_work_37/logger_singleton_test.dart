import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_home_work/home_work_37/singleton/logger_service.dart';

void main() {
  test('LoggerService should return same instance', () {
    final logger1 = LoggerService();
    final logger2 = LoggerService();

    expect(identical(logger1, logger2), true);
  });

  test('LoggerService instance should not be created twice', () {
    final logger1 = LoggerService();
    final logger2 = LoggerService();

    expect(logger1, same(logger2));
    expect(LoggerService.instanceCreatedCount, 1);
  });
}
