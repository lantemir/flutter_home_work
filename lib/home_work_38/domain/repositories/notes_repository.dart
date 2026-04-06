import '../entities/note_entity.dart';
import '../../shared/load_strategy.dart';

abstract class NotesRepository {
  Future<List<NoteEntity>> getNotes({
    LoadStrategy strategy = LoadStrategy.cacheThenRemote,
  });
}
