import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService._();

  static final LocalNotificationService instance = LocalNotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  final ValueNotifier<Map<String, dynamic>?> onNotificationTap =
      ValueNotifier<Map<String, dynamic>?>(null);

  Future<void> init() async {
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          onNotificationTap.value = Map<String, dynamic>.from(
            jsonDecode(payload),
          );
        }
      },
    );
  }

  Future<void> show({
    required int id,
    required String title,
    required String body,
    required Map<String, dynamic> payload,
  }) async {
    await _plugin.show(
      id: 1,
      title: "sdf",
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'hw34_channel',
          'HW34 Notifications',
          channelDescription: 'Foreground notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: jsonEncode(payload),
    );
  }
}
