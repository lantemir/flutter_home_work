import 'package:flutter/material.dart';

import '../data/datasources/notes_local_data_source.dart';
import '../data/datasources/notes_remote_data_source.dart';
import '../data/repositories/notes_repository_impl.dart';
import '../domain/entities/note_entity.dart';
import '../domain/usecases/get_notes_usecase.dart';
import '../shared/load_strategy.dart';
import '../shared/result_state.dart';

class NotesDemoPage extends StatefulWidget {
  const NotesDemoPage({super.key});

  @override
  State<NotesDemoPage> createState() => _NotesDemoPageState();
}

class _NotesDemoPageState extends State<NotesDemoPage> {
  late final GetNotesUseCase useCase;

  List<NoteEntity> notes = [];
  ResultState state = ResultState.idle;
  String? error;

  @override
  void initState() {
    super.initState();

    final repository = NotesRepositoryImpl(
      remoteDataSource: NotesRemoteDataSourceImpl(),
      localDataSource: NotesLocalDataSourceImpl(),
    );

    useCase = GetNotesUseCase(repository);

    _load(LoadStrategy.cacheThenRemote);
  }

  Future<void> _load(LoadStrategy strategy) async {
    setState(() {
      state = ResultState.loading;
      error = null;
    });

    try {
      final result = await useCase(strategy: strategy);
      setState(() {
        notes = result;
        state = ResultState.success;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        state = ResultState.error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HW38 Repository + Adapter')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => _load(LoadStrategy.localOnly),
                  child: const Text('Local only'),
                ),
                ElevatedButton(
                  onPressed: () => _load(LoadStrategy.remoteOnly),
                  child: const Text('Remote only'),
                ),
                ElevatedButton(
                  onPressed: () => _load(LoadStrategy.cacheThenRemote),
                  child: const Text('Cache → Remote'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Expanded(
              child: switch (state) {
                ResultState.loading => const Center(
                  child: CircularProgressIndicator(),
                ),
                ResultState.error => Center(
                  child: Text(error ?? 'Unknown error'),
                ),
                ResultState.success =>
                  notes.isEmpty
                      ? const Center(child: Text('No notes'))
                      : ListView.builder(
                          itemCount: notes.length,
                          itemBuilder: (_, i) {
                            final note = notes[i];
                            return Card(
                              child: ListTile(
                                title: Text(note.title),
                                subtitle: Text(note.content),
                              ),
                            );
                          },
                        ),
                ResultState.idle => const SizedBox.shrink(),
              },
            ),
          ],
        ),
      ),
    );
  }
}
