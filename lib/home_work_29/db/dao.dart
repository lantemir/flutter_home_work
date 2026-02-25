import 'package:drift/drift.dart';
import 'app_db.dart';
import 'tables.dart';

enum TaskSort { dateDesc, dateAsc, priorityDesc, priorityAsc }

class TasksDao {
  TasksDao(this.db);
  final AppDatabase db;

  // ---------- TAGS ----------
  Future<int> upsertTag(String name) async {
    // Insert or ignore (because unique key)
    return db
        .into(db.tags)
        .insert(
          TagsCompanion.insert(name: name),
          mode: InsertMode.insertOrIgnore,
        );
  }

  Future<List<Tag>> getAllTags() => db.select(db.tags).get();

  // ---------- TASKS CRUD ----------
  Future<int> addTask({
    required String title,
    String? description,
    TaskPriority priority = TaskPriority.medium,
    List<String> tagNames = const [],
  }) async {
    final taskId = await db
        .into(db.tasks)
        .insert(
          TasksCompanion.insert(
            title: title,
            description: Value(description),
            priority: Value(priority),
          ),
        );

    await _setTagsForTask(taskId, tagNames);
    return taskId;
  }

  Future<void> updateTask({
    required int taskId,
    required String title,
    String? description,
    required TaskPriority priority,
    required bool isCompleted,
    List<String> tagNames = const [],
  }) async {
    await (db.update(db.tasks)..where((t) => t.id.equals(taskId))).write(
      TasksCompanion(
        title: Value(title),
        description: Value(description),
        priority: Value(priority),
        isCompleted: Value(isCompleted),
      ),
    );

    await _setTagsForTask(taskId, tagNames);
  }

  Future<void> deleteTask(int taskId) async {
    await (db.delete(db.tasks)..where((t) => t.id.equals(taskId))).go();
  }

  Future<void> toggleCompleted(Task task) async {
    await (db.update(db.tasks)..where((t) => t.id.equals(task.id))).write(
      TasksCompanion(isCompleted: Value(!task.isCompleted)),
    );
  }

  // ---------- RELATION HELPERS ----------
  Future<void> _setTagsForTask(int taskId, List<String> tagNames) async {
    // очистить старые связи
    await (db.delete(
      db.taskTags,
    )..where((tt) => tt.taskId.equals(taskId))).go();

    for (final name
        in tagNames.map((e) => e.trim()).where((e) => e.isNotEmpty)) {
      await upsertTag(name);
      final tag = await (db.select(
        db.tags,
      )..where((t) => t.name.equals(name))).getSingle();

      await db
          .into(db.taskTags)
          .insert(
            TaskTagsCompanion.insert(taskId: taskId, tagId: tag.id),
            mode: InsertMode.insertOrIgnore,
          );
    }
  }

  // ---------- READ: get() vs watch() ----------
  Future<List<Task>> getTasksOnce(TaskSort sort) {
    final q = db.select(db.tasks);
    _applySort(q, sort);
    return q.get();
  }

  Stream<List<Task>> watchTasks(TaskSort sort) {
    final q = db.select(db.tasks);
    _applySort(q, sort);
    return q.watch();
  }

  void _applySort(SimpleSelectStatement<Tasks, Task> q, TaskSort sort) {
    switch (sort) {
      case TaskSort.dateDesc:
        q.orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
        break;
      case TaskSort.dateAsc:
        q.orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
        break;
      case TaskSort.priorityDesc:
        q.orderBy([
          (t) => OrderingTerm.desc(t.priority),
          (t) => OrderingTerm.desc(t.createdAt),
        ]);
        break;
      case TaskSort.priorityAsc:
        q.orderBy([
          (t) => OrderingTerm.asc(t.priority),
          (t) => OrderingTerm.desc(t.createdAt),
        ]);
        break;
    }
  }

  // Опционально: получить теги задачи
  Future<List<Tag>> getTagsForTask(int taskId) async {
    final q = db.select(db.tags).join([
      innerJoin(db.taskTags, db.taskTags.tagId.equalsExp(db.tags.id)),
    ])..where(db.taskTags.taskId.equals(taskId));
    final rows = await q.get();
    return rows.map((r) => r.readTable(db.tags)).toList();
  }
}
