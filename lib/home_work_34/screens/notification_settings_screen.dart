import 'package:flutter/material.dart';
import '../services/notification_settings_service.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  final NotificationSettingsService _service = NotificationSettingsService();

  bool _enabled = true;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _enabled = await _service.getEnabled();
    setState(() => _loading = false);
  }

  Future<void> _update(bool value) async {
    await _service.setEnabled(value);
    setState(() => _enabled = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Settings')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SwitchListTile(
              value: _enabled,
              onChanged: _update,
              title: const Text('Enable local notifications'),
              subtitle: const Text('Foreground local display on/off'),
            ),
    );
  }
}
