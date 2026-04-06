class NoteApiModel {
  final dynamic id;
  final dynamic title;
  final dynamic body;

  NoteApiModel({required this.id, required this.title, required this.body});

  factory NoteApiModel.fromJson(Map<String, dynamic> json) {
    return NoteApiModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
