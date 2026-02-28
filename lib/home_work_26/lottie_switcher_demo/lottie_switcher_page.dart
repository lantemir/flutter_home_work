import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieSwitcherPage extends StatefulWidget {
  const LottieSwitcherPage({super.key});

  @override
  State<LottieSwitcherPage> createState() => _LottieSwitcherPageState();
}

class _LottieSwitcherPageState extends State<LottieSwitcherPage> {
  bool _loading = false;
  bool _success = false;

  Future<void> _run() async {
    setState(() {
      _loading = true;
      _success = false;
    });

    await Future<void>.delayed(const Duration(seconds: 2));

    setState(() {
      _loading = false;
      _success = true;
    });

    await Future<void>.delayed(const Duration(seconds: 1));

    setState(() {
      _success = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (_loading) {
      child = Column(
        key: const ValueKey('loading'),
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('assets/lottie/loading.json', height: 140),
          const SizedBox(height: 8),
          const Text('Loading...'),
        ],
      );
    } else if (_success) {
      child = Column(
        key: const ValueKey('success'),
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/lottie/success.json',
            height: 140,
            repeat: false,
          ),
          const SizedBox(height: 8),
          const Text('Success ✅'),
        ],
      );
    } else {
      child = Column(
        key: const ValueKey('content'),
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.widgets_outlined, size: 60),
          SizedBox(height: 8),
          Text('Press button to start'),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Lottie + AnimatedSwitcher')),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) {
            // разные transitionBuilder: fade + slight slide
            final fade = FadeTransition(opacity: animation, child: child);
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.06),
                end: Offset.zero,
              ).animate(animation),
              child: fade,
            );
          },
          child: child,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loading ? null : _run,
        label: const Text('Run'),
        icon: const Icon(Icons.play_arrow),
      ),
    );
  }
}
