import 'package:flutter_home_work/home_work_38/data/models/note_api_model.dart';

class NoteFixtures {
  static NoteApiModel validApiNote1 = NoteApiModel(
    id: 1,
    title: 'Test title',
    body: 'Test body',
  );

  static NoteApiModel validApiNote2 = NoteApiModel(
    id: '22',
    title: 'Another title',
    body: 'Another body',
  );

  static NoteApiModel emptyTitleNote = NoteApiModel(
    id: 3,
    title: '',
    body: 'Body exists',
  );

  static NoteApiModel nullIdNote = NoteApiModel(
    id: null,
    title: 'Broken note',
    body: 'Invalid because id is null',
  );

  static NoteApiModel spacesTitleNote = NoteApiModel(
    id: 5,
    title: '   ',
    body: 'Only spaces in title',
  );
}
