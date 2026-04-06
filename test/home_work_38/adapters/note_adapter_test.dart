import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_home_work/home_work_38/data/adapters/note_adapter.dart';
import 'package:flutter_home_work/home_work_38/domain/entities/note_entity.dart';

import '../fixtures/note_fixtures.dart';

void main() {
  group('NoteAdapter.fromApi', () {
    test('should map valid api model with int id to NoteEntity', () {
      final result = NoteAdapter.fromApi(NoteFixtures.validApiNote1);

      expect(result, isA<NoteEntity>());
      expect(result.id, '1');
      expect(result.title, 'Test title');
      expect(result.content, 'Test body');
    });

    test('should map valid api model with string id to NoteEntity', () {
      final result = NoteAdapter.fromApi(NoteFixtures.validApiNote2);

      expect(result.id, '22');
      expect(result.title, 'Another title');
      expect(result.content, 'Another body');
    });

    test('should throw when title is empty', () {
      expect(
        () => NoteAdapter.fromApi(NoteFixtures.emptyTitleNote),
        throwsException,
      );
    });

    test('should throw when id is null', () {
      expect(
        () => NoteAdapter.fromApi(NoteFixtures.nullIdNote),
        throwsException,
      );
    });

    test('should throw when title contains only spaces', () {
      expect(
        () => NoteAdapter.fromApi(NoteFixtures.spacesTitleNote),
        throwsException,
      );
    });
  });
}
