import 'package:flutter/material.dart';

class AnimatedDots extends StatelessWidget {
  final int count;
  final double page; // текущая позиция PageView (0..)
  const AnimatedDots({super.key, required this.count, required this.page});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final selected = (page - i).abs() < 0.5;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 8,
          width: selected ? 22 : 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: selected ? Colors.black87 : Colors.black26,
          ),
        );
      }),
    );
  }
}
