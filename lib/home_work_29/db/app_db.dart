import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables.dart';

part 'app_db.g.dart'; // Это подключение сгенерированного файла. Drift генерирует класс _$AppDatabase и кучу вспомогательного кода.

@DriftDatabase(tables: [Tasks, Tags, TaskTags])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // v1: без priority
  // v2: добавили priority (если хочешь миграцию)
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      if (from == 1) {
        // ✅ optional migration: добавляем новое поле priority
        await m.addColumn(tasks, tasks.priority);

        // и заполняем дефолтом (medium=1) для старых строк
        await customStatement(
          'UPDATE tasks SET priority = 1 WHERE priority IS NULL',
        );
      }
    },
  );
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'hw29.sqlite', native: const DriftNativeOptions());
}
