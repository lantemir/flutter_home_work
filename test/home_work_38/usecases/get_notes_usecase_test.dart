import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_home_work/home_work_38/domain/entities/note_entity.dart';
import 'package:flutter_home_work/home_work_38/domain/usecases/get_notes_usecase.dart';
import 'package:flutter_home_work/home_work_38/shared/load_strategy.dart';

import '../repositories/fake_notes_repository.dart';

void main() {
  group('GetNotesUseCase', () {
    test('should return list of notes from repository', () async {
      final repo = FakeSuccessNotesRepository([
        const NoteEntity(id: '1', title: 'Note 1', content: 'Body 1'),
        const NoteEntity(id: '2', title: 'Note 2', content: 'Body 2'),
      ]);

      final useCase = GetNotesUseCase(repo);

      final result = await useCase(strategy: LoadStrategy.localOnly);

      expect(result.length, 2);
      expect(result.first.title, 'Note 1');
    });

    test(
      'should return empty list when repository returns empty list',
      () async {
        final repo = FakeSuccessNotesRepository([]);
        final useCase = GetNotesUseCase(repo);

        final result = await useCase();

        expect(result, isEmpty);
      },
    );

    test('should throw exception when repository fails', () async {
      final repo = FakeFailureNotesRepository('Server error');
      final useCase = GetNotesUseCase(repo);

      expect(() => useCase(), throwsA(isA<Exception>()));
    });
  });
}
