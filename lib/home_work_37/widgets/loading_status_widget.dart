import 'package:flutter/material.dart';

class LoadingStatusWidget extends StatelessWidget {
  const LoadingStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 12),
        Text('Loading...'),
      ],
    );
  }
}
