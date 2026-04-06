import '../entities/note_entity.dart';
import '../repositories/notes_repository.dart';
import '../../shared/load_strategy.dart';

class GetNotesUseCase {
  final NotesRepository repository;

  GetNotesUseCase(this.repository);

  Future<List<NoteEntity>> call({
    LoadStrategy strategy = LoadStrategy.cacheThenRemote,
  }) {
    return repository.getNotes(strategy: strategy);
  }
}
