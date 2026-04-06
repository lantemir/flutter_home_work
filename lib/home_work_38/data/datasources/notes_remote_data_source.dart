import '../models/note_api_model.dart';

abstract class NotesRemoteDataSource {
  Future<List<NoteApiModel>> fetchNotes();
}

class NotesRemoteDataSourceImpl implements NotesRemoteDataSource {
  @override
  Future<List<NoteApiModel>> fetchNotes() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));

    return [
      NoteApiModel(id: 1, title: 'Remote note 1', body: 'Body from server'),
      NoteApiModel(id: 2, title: 'Remote note 2', body: 'Another body'),
      // Можно временно проверить некорректные данные:
      // NoteApiModel(id: null, title: '', body: 'broken'),
    ];
  }
}
