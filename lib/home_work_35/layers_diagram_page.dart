import 'package:flutter/material.dart';

class LayersDiagramPage extends StatelessWidget {
  const LayersDiagramPage({super.key});

  @override
  Widget build(BuildContext context) {
    const text = '''
Layer diagram (HW35)

1. UI Layer
- Screens / Widgets
- показывает данные
- принимает ввод пользователя

2. Controller / Presenter Layer
- обрабатывает действия пользователя
- вызывает load/add
- готовит данные для UI
- обрабатывает ошибки через ErrorHandler

3. Data Layer
- Repository
- источник данных (в этом примере fake repository)

4. Shared / Model Layer
- TaskEntity
- ErrorHandler

Responsibilities:
- UI: render + events
- MVC Controller / MVP Presenter: business logic
- Repository: load/save data
- ErrorHandler: единая обработка ошибок
''';

    return Scaffold(
      appBar: AppBar(title: const Text('Layers Diagram')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(text, style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
