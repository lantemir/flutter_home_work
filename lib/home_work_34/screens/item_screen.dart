import 'package:flutter/material.dart';

class ItemScreen extends StatelessWidget {
  final String itemId;

  const ItemScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Item Screen')),
      body: Center(
        child: Text(
          'Opened item by payload id: $itemId',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
