import 'package:flutter/material.dart';

class ErrorStatusWidget extends StatelessWidget {
  final String message;

  const ErrorStatusWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error, size: 52, color: Colors.red),
        const SizedBox(height: 12),
        Text(message, textAlign: TextAlign.center),
      ],
    );
  }
}
