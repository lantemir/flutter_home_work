import '../../domain/entities/note_entity.dart';
import '../models/note_api_model.dart';
import '../models/note_local_model.dart';

class NoteAdapter {
  static NoteEntity fromApi(NoteApiModel model) {
    final id = model.id?.toString() ?? '';
    final title = model.title?.toString().trim() ?? '';
    final content = model.body?.toString().trim() ?? '';

    if (id.isEmpty || title.isEmpty) {
      throw Exception('Invalid API note model');
    }

    return NoteEntity(id: id, title: title, content: content);
  }

  static NoteEntity fromLocal(NoteLocalModel model) {
    if (model.id.trim().isEmpty || model.title.trim().isEmpty) {
      throw Exception('Invalid local note model');
    }

    return NoteEntity(id: model.id, title: model.title, content: model.content);
  }

  static NoteLocalModel toLocal(NoteEntity entity) {
    return NoteLocalModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
    );
  }
}
