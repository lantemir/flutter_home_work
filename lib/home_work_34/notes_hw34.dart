import 'package:flutter/material.dart';

class Hw34NotesPage extends StatelessWidget {
  const Hw34NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const notes = '''
HW34 — Push Notifications / FCM

1. Push и состояния приложения
- foreground: приложение открыто
- background: приложение свернуто
- terminated: приложение закрыто
В каждом состоянии уведомления обрабатываются по-разному.

2. FCM token
- уникальный токен устройства/инсталляции
- нужен для отправки push на конкретное устройство
- токен может обновляться, его нужно пересохранять

3. Разрешения
- iOS требует явный запрос разрешения
- Android 13+ тоже требует runtime permission на notifications
- foreground push может не показываться сам, нужен local notification

4. Обработка по payload
- в data payload передаём route, itemId и др.
- по нажатию открываем нужный экран

5. Topic notifications
- можно подписывать устройства на topic (например news)
- удобно для массовых уведомлений

Ошибки:
- не сохранять token refresh
- не обрабатывать getInitialMessage()
- забыть local notification для foreground
''';

    return Scaffold(
      appBar: AppBar(title: const Text('HW34 Notes')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(child: Text(notes)),
      ),
    );
  }
}
