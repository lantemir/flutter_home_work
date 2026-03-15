import 'package:flutter/material.dart';

import '../models/notification_item.dart';
import '../services/notification_service.dart';
import 'notification_details_screen.dart';
import 'notification_settings_screen.dart';
import 'item_screen.dart';
import '../widgets/log_tile.dart';

class NotificationsHomeScreen extends StatefulWidget {
  const NotificationsHomeScreen({super.key});

  @override
  State<NotificationsHomeScreen> createState() =>
      _NotificationsHomeScreenState();
}

class _NotificationsHomeScreenState extends State<NotificationsHomeScreen> {
  final NotificationService _service = NotificationService.instance;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    if (_initialized) return;
    _initialized = true;

    await _service.init();

    _service.openedNotification.addListener(_handleOpen);
    setState(() {});
  }

  void _handleOpen() {
    final item = _service.openedNotification.value;
    if (item == null || !mounted) return;

    if (item.itemId != null && item.itemId!.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ItemScreen(itemId: item.itemId!)),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NotificationDetailsScreen(item: item)),
    );
  }

  @override
  void dispose() {
    _service.openedNotification.removeListener(_handleOpen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HW34 Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationSettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<List<String>>(
        valueListenable: _service.logs,
        builder: (context, logs, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Практика дня:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text('• Отправь тестовое push из Firebase Console'),
              const Text('• Попробуй foreground / background / terminated'),
              const Text('• Добавь payload: route, itemId'),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _service.subscribeToTopic('news'),
                      child: const Text('Subscribe news'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _service.unsubscribeFromTopic('news'),
                      child: const Text('Unsubscribe news'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text(
                'Logs',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              if (logs.isEmpty)
                const Text('Пока логов нет')
              else
                ...logs.map((e) => LogTile(text: e)),
            ],
          );
        },
      ),
    );
  }
}
