class NoteLocalModel {
  final String id;
  final String title;
  final String content;

  NoteLocalModel({
    required this.id,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'content': content};
  }

  factory NoteLocalModel.fromMap(Map<String, dynamic> map) {
    return NoteLocalModel(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      content: map['content']?.toString() ?? '',
    );
  }
}
