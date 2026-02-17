import 'package:flutter/material.dart';

class ControllerDemo extends StatefulWidget {
  const ControllerDemo({super.key});

  @override
  State<ControllerDemo> createState() => _ControllerDemoState();
}

class _ControllerDemoState extends State<ControllerDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // важно
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimationController demo')),
      body: Center(
        child: FadeTransition(
          opacity: _controller,
          child: const Text('Hello', style: TextStyle(fontSize: 44)),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            ElevatedButton(
              onPressed: () => _controller.forward(),
              child: const Text('forward'),
            ),
            ElevatedButton(
              onPressed: () => _controller.reverse(),
              child: const Text('reverse'),
            ),
            ElevatedButton(
              onPressed: () => _controller.repeat(reverse: true),
              child: const Text('repeat'),
            ),
            ElevatedButton(
              onPressed: () => _controller.stop(),
              child: const Text('stop'),
            ),
          ],
        ),
      ),
    );
  }
}
