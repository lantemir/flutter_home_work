import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../models/notification_item.dart';
import 'local_notification_service.dart';
import 'notification_settings_service.dart';
import 'token_store_service.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final NotificationSettingsService _settingsService =
      NotificationSettingsService();
  final TokenStoreService _tokenStoreService = TokenStoreService();

  final ValueNotifier<List<String>> logs = ValueNotifier<List<String>>([]);
  final ValueNotifier<NotificationItem?> openedNotification =
      ValueNotifier<NotificationItem?>(null);

  void _log(String message) {
    logs.value = [message, ...logs.value];
    debugPrint(message);
  }

  Future<void> init() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    _log('Permission status: ${settings.authorizationStatus}');

    final token = await _messaging.getToken();
    _log('FCM token: $token');

    if (token != null) {
      await _tokenStoreService.saveToken(token);
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      _log('Token refreshed: $newToken');
      await _tokenStoreService.saveToken(newToken);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      _log('Foreground message received: ${message.messageId}');
      _log('Foreground data: ${message.data}');

      final enabled = await _settingsService.getEnabled();
      if (!enabled) {
        _log('Notifications disabled locally. Skip local show.');
        return;
      }

      final title = message.notification?.title ?? 'New notification';
      final body = message.notification?.body ?? 'No body';

      await LocalNotificationService.instance.show(
        id: 1,
        title: title,
        body: body,
        payload: message.data,
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _log('Notification opened from background: ${message.messageId}');
      _handleMessageOpen(message);
    });

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _log(
        'Notification opened from terminated state: ${initialMessage.messageId}',
      );
      _handleMessageOpen(initialMessage);
    }

    LocalNotificationService.instance.onNotificationTap.addListener(() {
      final data = LocalNotificationService.instance.onNotificationTap.value;
      if (data == null) return;

      _log('Local notification tapped: $data');

      openedNotification.value = NotificationItem.fromMessage(
        title: data['title']?.toString(),
        body: data['body']?.toString(),
        data: data,
      );
    });
  }

  void _handleMessageOpen(RemoteMessage message) {
    openedNotification.value = NotificationItem.fromMessage(
      title: message.notification?.title,
      body: message.notification?.body,
      data: message.data,
    );
  }

  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    _log('Subscribed to topic: $topic');
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    _log('Unsubscribed from topic: $topic');
  }
}
