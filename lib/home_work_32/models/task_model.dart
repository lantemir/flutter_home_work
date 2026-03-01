import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String? description;
  final bool completed;
  final String category;
  final String userId;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.completed,
    required this.category,
    required this.userId,
    required this.createdAt,
  });

  factory Task.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      completed: data['completed'],
      category: data['category'],
      userId: data['userId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'completed': completed,
      'category': category,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
