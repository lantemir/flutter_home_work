import 'package:flutter/material.dart';

class Hw38NotesPage extends StatelessWidget {
  const Hw38NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const text = '''
HW38 — Repository / Adapter / Datasource / Cache

1. Repository
Repository — это слой между domain и data.
В domain объявляется интерфейс, а в data — реализация.
Задача repository: скрыть от domain, откуда пришли данные (API, DB, cache).

2. Adapter
Adapter преобразует внешний формат в удобный для домена.
Например:
- API model -> domain entity
- local DB model -> domain entity
- domain entity -> local model

3. Mapping cases
- Нормальные данные: entity создаётся успешно
- Пустые данные: adapter выбрасывает ошибку
- Некорректные данные: adapter выбрасывает ошибку

4. Datasource
- Remote datasource: получает данные с сервера
- Local datasource: получает/сохраняет данные локально

5. Cache strategy
Сначала локальный кэш, потом сервер.
Это ускоряет UI и позволяет показывать данные даже без сети.

6. Strategy switch
Можно выбирать:
- localOnly
- remoteOnly
- cacheThenRemote

Плюсы подхода:
- чище архитектура
- проще тестировать
- можно менять источник данных без изменения domain
''';

    return Scaffold(
      appBar: AppBar(title: const Text('HW38 Notes')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(child: Text(text)),
      ),
    );
  }
}
