import 'package:flutter/material.dart';
import 'widgets/animated_dots.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _pc;
  double _page = 0;

  final _pages = const [
    _OnbPage(title: 'Welcome', text: 'PageView + анимированные индикаторы'),
    _OnbPage(
      title: 'Features',
      text: 'Staggered/AnimatedSwitcher/Lottie можно комбинировать',
    ),
    _OnbPage(title: 'Ready', text: 'Нажми Finish чтобы закрыть'),
  ];

  @override
  void initState() {
    super.initState();
    _pc = PageController()
      ..addListener(() {
        setState(() => _page = _pc.page ?? 0);
      });
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final last = _page.round() == _pages.length - 1;

    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding (3 pages)')),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pc,
              itemCount: _pages.length,
              itemBuilder: (_, i) => _pages[i],
            ),
          ),
          const SizedBox(height: 12),
          AnimatedDots(count: _pages.length, page: _page),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (!last) {
                    _pc.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Text(last ? 'Finish' : 'Next'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnbPage extends StatelessWidget {
  final String title;
  final String text;
  const _OnbPage({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
