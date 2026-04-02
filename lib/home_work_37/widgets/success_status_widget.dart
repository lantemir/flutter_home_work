import 'package:flutter/material.dart';

class SuccessStatusWidget extends StatelessWidget {
  final String message;

  const SuccessStatusWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle, size: 52, color: Colors.green),
        const SizedBox(height: 12),
        Text(message),
      ],
    );
  }
}
