import '../models/note_local_model.dart';

abstract class NotesLocalDataSource {
  Future<List<NoteLocalModel>> getCachedNotes();
  Future<void> cacheNotes(List<NoteLocalModel> notes);
  Future<void> clearCache();
}

class NotesLocalDataSourceImpl implements NotesLocalDataSource {
  List<Map<String, dynamic>> _cache = [
    {'id': '101', 'title': 'Cached note', 'content': 'Loaded from local cache'},
  ];

  @override
  Future<List<NoteLocalModel>> getCachedNotes() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return _cache.map(NoteLocalModel.fromMap).toList();
  }

  @override
  Future<void> cacheNotes(List<NoteLocalModel> notes) async {
    _cache = notes.map((e) => e.toMap()).toList();
  }

  @override
  Future<void> clearCache() async {
    _cache = [];
  }
}
