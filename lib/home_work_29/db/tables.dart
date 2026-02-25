import 'package:drift/drift.dart';

enum TaskPriority { low, medium, high }

// Converter: enum <-> int (0/1/2)
class TaskPriorityConverter extends TypeConverter<TaskPriority, int> {
  const TaskPriorityConverter();
  @override
  TaskPriority fromSql(int fromDb) => TaskPriority.values[fromDb];

  @override
  int toSql(TaskPriority value) => value.index;
}

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 120)();

  TextColumn get description => text().nullable()();

  // сортировка по дате
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  // сортировка по приоритету (enum)
  IntColumn get priority => integer()
      .map(const TaskPriorityConverter())
      .withDefault(const Constant(1))(); // medium

  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 40).unique()();

  // чтобы теги не дублировались
  // @override
  // List<Set<Column>> get uniqueKeys => [
  //       {name},
  // ];
}

/// Join table: many-to-many (одна задача может иметь много тегов, тег может быть у многих задач)
class TaskTags extends Table {
  IntColumn get taskId =>
      integer().references(Tasks, #id, onDelete: KeyAction.cascade)();

  IntColumn get tagId =>
      integer().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {taskId, tagId};
}
