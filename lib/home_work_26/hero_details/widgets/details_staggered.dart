import 'package:flutter/material.dart';

class DetailsStaggered extends StatelessWidget {
  final AnimationController controller;

  const DetailsStaggered({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final a1 = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );
    final a2 = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.25, 0.7, curve: Curves.easeOutCubic),
    );
    final a3 = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.55, 1.0, curve: Curves.easeOut),
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: a1.value,
              child: const Text(
                'Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Transform.translate(
              offset: Offset(0, (1 - a2.value) * 18),
              child: Opacity(
                opacity: a2.value,
                child: const Text(
                  'Здесь плавно появляются детали после Hero-перехода.\nИспользуем один controller + Interval.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Transform.scale(
              scale: 0.95 + 0.05 * a3.value,
              child: Opacity(
                opacity: a3.value,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    Chip(label: Text('Tag 1')),
                    Chip(label: Text('Tag 2')),
                    Chip(label: Text('Tag 3')),
                    Chip(label: Text('Tag 4')),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
