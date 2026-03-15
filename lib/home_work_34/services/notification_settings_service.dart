import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingsService {
  static const _keyEnabled = 'notifications_enabled';

  Future<bool> getEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyEnabled) ?? true;
  }

  Future<void> setEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyEnabled, value);
  }
}
