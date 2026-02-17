import 'package:flutter/material.dart';

import 'implicit_demo.dart';
import 'controller_demo.dart';
import 'tween_curve_demo.dart';
import 'animated_builder_demo.dart';
import 'practice_animation_screen.dart';

class HomeWork25 extends StatelessWidget {
  const HomeWork25({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Work 25 — Animations')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _NavTile(
            title: '1) Implicit demo (AnimatedContainer)',
            subtitle: 'implicit: меняем параметры → Flutter анимирует сам',
            onTap: () => _open(context, const ImplicitDemo()),
          ),
          _NavTile(
            title: '2) Controller demo (forward/reverse/repeat/stop)',
            subtitle:
                'explicit: ручной контроль времени через AnimationController',
            onTap: () => _open(context, const ControllerDemo()),
          ),
          _NavTile(
            title: '3) Tween + CurvedAnimation demo',
            subtitle: 'диапазон значений + кривая скорости',
            onTap: () => _open(context, const TweenCurveDemo()),
          ),
          _NavTile(
            title: '4) AnimatedBuilder demo (оптимизация)',
            subtitle: 'child не пересоздаётся на каждом кадре',
            onTap: () => _open(context, const AnimatedBuilderDemo()),
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          _NavTile(
            title: '✅ Practice: Offset + Scale (start/stop/reverse)',
            subtitle: 'итоговый экран задания',
            onTap: () => _open(context, const PracticeAnimationScreen()),
          ),
        ],
      ),
    );
  }

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
