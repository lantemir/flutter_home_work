import 'package:flutter_home_work/home_work_38/domain/entities/note_entity.dart';
import 'package:flutter_home_work/home_work_38/domain/repositories/notes_repository.dart';
import 'package:flutter_home_work/home_work_38/shared/load_strategy.dart';

class FakeSuccessNotesRepository implements NotesRepository {
  final List<NoteEntity> items;

  FakeSuccessNotesRepository(this.items);

  @override
  Future<List<NoteEntity>> getNotes({
    LoadStrategy strategy = LoadStrategy.cacheThenRemote,
  }) async {
    return items;
  }
}

class FakeFailureNotesRepository implements NotesRepository {
  final String message;

  FakeFailureNotesRepository(this.message);

  @override
  Future<List<NoteEntity>> getNotes({
    LoadStrategy strategy = LoadStrategy.cacheThenRemote,
  }) async {
    throw Exception(message);
  }
}
