import 'package:flutter/material.dart';

class LogTile extends StatelessWidget {
  final String text;

  const LogTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(padding: const EdgeInsets.all(12), child: Text(text)),
    );
  }
}
