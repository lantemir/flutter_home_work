import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/notes_repository.dart';
import '../../shared/load_strategy.dart';
import '../adapters/note_adapter.dart';
import '../datasources/notes_local_data_source.dart';
import '../datasources/notes_remote_data_source.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesRemoteDataSource remoteDataSource;
  final NotesLocalDataSource localDataSource;

  NotesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<NoteEntity>> getNotes({
    LoadStrategy strategy = LoadStrategy.cacheThenRemote,
  }) async {
    switch (strategy) {
      case LoadStrategy.localOnly:
        final localModels = await localDataSource.getCachedNotes();
        return localModels.map(NoteAdapter.fromLocal).toList();

      case LoadStrategy.remoteOnly:
        final remoteModels = await remoteDataSource.fetchNotes();
        final entities = remoteModels.map(NoteAdapter.fromApi).toList();
        await localDataSource.cacheNotes(
          entities.map(NoteAdapter.toLocal).toList(),
        );
        return entities;

      case LoadStrategy.cacheThenRemote:
        final cached = await localDataSource.getCachedNotes();

        if (cached.isNotEmpty) {
          return cached.map(NoteAdapter.fromLocal).toList();
        }

        final remoteModels = await remoteDataSource.fetchNotes();
        final entities = remoteModels.map(NoteAdapter.fromApi).toList();

        await localDataSource.cacheNotes(
          entities.map(NoteAdapter.toLocal).toList(),
        );

        return entities;
    }
  }
}
