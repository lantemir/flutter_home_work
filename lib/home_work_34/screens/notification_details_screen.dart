import 'package:flutter/material.dart';
import '../models/notification_item.dart';

class NotificationDetailsScreen extends StatelessWidget {
  final NotificationItem item;

  const NotificationDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Title: ${item.title ?? '-'}'),
            const SizedBox(height: 8),
            Text('Body: ${item.body ?? '-'}'),
            const SizedBox(height: 8),
            Text('Route: ${item.route ?? '-'}'),
            const SizedBox(height: 8),
            Text('ItemId: ${item.itemId ?? '-'}'),
            const SizedBox(height: 16),
            const Text(
              'Raw payload:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(item.rawData.toString()),
          ],
        ),
      ),
    );
  }
}
