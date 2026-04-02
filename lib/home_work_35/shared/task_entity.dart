class TaskEntity {
  final String id;
  final String title;
  final bool completed;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.completed,
  });

  TaskEntity copyWith({String? id, String? title, bool? completed}) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
