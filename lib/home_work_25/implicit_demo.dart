import 'package:flutter/material.dart';

class ImplicitDemo extends StatefulWidget {
  const ImplicitDemo({super.key});

  @override
  State<ImplicitDemo> createState() => _ImplicitDemoState();
}

class _ImplicitDemoState extends State<ImplicitDemo> {
  bool _big = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Implicit demo')),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOut,
          width: _big ? 220 : 120,
          height: _big ? 220 : 120,
          decoration: BoxDecoration(
            color: _big ? Colors.orange : Colors.blue,
            borderRadius: BorderRadius.circular(_big ? 32 : 8),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _big = !_big),
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
