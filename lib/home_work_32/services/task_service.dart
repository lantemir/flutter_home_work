import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';

class TaskService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference get _tasks => _db.collection('tasks');

  // REALTIME
  Stream<List<Task>> streamTasks({String? category, bool? completed}) {
    Query query = _tasks
        .where('userId', isEqualTo: _uid)
        .orderBy('createdAt', descending: true);

    if (category != null) {
      query = query.where('category', isEqualTo: category);
    }

    if (completed != null) {
      query = query.where('completed', isEqualTo: completed);
    }

    return query.snapshots().map(
      (snap) => snap.docs.map((doc) => Task.fromDoc(doc)).toList(),
    );
  }

  // PAGINATION
  Future<List<Task>> fetchTasks({
    DocumentSnapshot? lastDoc,
    int limit = 10,
  }) async {
    Query query = _tasks
        .where('userId', isEqualTo: _uid)
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }

    final snap = await query.get();

    return snap.docs.map((e) => Task.fromDoc(e)).toList();
  }

  Future<void> addTask(Task task) async {
    await _tasks.add(task.toMap());
  }

  Future<void> updateTask(Task task) async {
    await _tasks.doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String id) async {
    await _tasks.doc(id).delete();
  }
}
