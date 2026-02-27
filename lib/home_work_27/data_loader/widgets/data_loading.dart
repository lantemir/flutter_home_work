import 'package:flutter/material.dart';

class DataLoadingView extends StatelessWidget {
  const DataLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
