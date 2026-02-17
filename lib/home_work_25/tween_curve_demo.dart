import 'package:flutter/material.dart';

class TweenCurveDemo extends StatefulWidget {
  const TweenCurveDemo({super.key});

  @override
  State<TweenCurveDemo> createState() => _TweenCurveDemoState();
}

class _TweenCurveDemoState extends State<TweenCurveDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _scale = Tween<double>(begin: 0.8, end: 1.15).animate(curved);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tween + Curve demo')),
      body: Center(
        child: ScaleTransition(
          scale: _scale,
          child: const Icon(Icons.star, size: 90),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.forward(from: 0),
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
