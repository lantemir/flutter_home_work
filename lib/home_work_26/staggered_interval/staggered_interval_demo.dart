import 'package:flutter/material.dart';

class StaggeredIntervalDemoPage extends StatefulWidget {
  const StaggeredIntervalDemoPage({super.key});

  @override
  State<StaggeredIntervalDemoPage> createState() =>
      _StaggeredIntervalDemoPageState();
}

class _StaggeredIntervalDemoPageState extends State<StaggeredIntervalDemoPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _titleOpacity;
  late final Animation<double> _cardSlide;
  late final Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _titleOpacity = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
    );
    _cardSlide = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic),
    );
    _buttonScale = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.6, 1.0, curve: Curves.elasticOut),
    );

    _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _replay() => _c.forward(from: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staggered (Interval)')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AnimatedBuilder(
            animation: _c,
            builder: (context, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Opacity(
                    opacity: _titleOpacity.value,
                    child: const Text(
                      'Step 1: Title',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Transform.translate(
                    offset: Offset(0, (1 - _cardSlide.value) * 30),
                    child: Opacity(
                      opacity: _cardSlide.value,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: const [
                              Text('Step 2: Card appears after title'),
                              SizedBox(height: 8),
                              Text('Interval(0.2..0.7) управляет появлением'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Transform.scale(
                    scale: 0.8 + 0.2 * _buttonScale.value,
                    child: ElevatedButton(
                      onPressed: _replay,
                      child: const Text('Replay'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
