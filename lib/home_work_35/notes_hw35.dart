import 'package:flutter/material.dart';

class Hw35NotesPage extends StatelessWidget {
  const Hw35NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const text = '''
HW35 — MVC / MVP

1) MVC
- Model: данные и источник данных
- View: экран/виджеты
- Controller: принимает действия пользователя и обновляет состояние

Плюсы:
- проще стартовать
- меньше файлов

Минусы:
- Controller часто начинает знать слишком много о View
- сложнее масштабировать при росте логики

2) MVP
- Model: данные
- View: интерфейс экрана
- Presenter: бизнес-логика отдельно от UI

Плюсы:
- логика лучше отделена
- Presenter легче тестировать и переиспользовать
- UI становится "тупее" и чище

Минусы:
- больше шаблонного кода
- нужно поддерживать contract/interface

Что стало проще в MVP:
- легче выносить бизнес-логику
- чище обязанности слоёв

Что стало сложнее:
- больше файлов
- больше связей между View и Presenter

Business logic вынесена из UI:
- load()
- add()

ErrorHandler:
- единая точка преобразования ошибок в пользовательские сообщения
''';

    return Scaffold(
      appBar: AppBar(title: const Text('HW35 Notes')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(child: Text(text)),
      ),
    );
  }
}
