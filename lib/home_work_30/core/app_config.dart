import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  AppConfig({required this.isRealApi, required this.prefs});

  final bool isRealApi;
  final SharedPreferences prefs;

  static bool defaultIsRealApi() {
    // В release -> Real, в debug/profile -> Mock
    return kReleaseMode;
  }
}
