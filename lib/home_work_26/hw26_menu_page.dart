import 'package:flutter/material.dart';

import 'notes_hw26.dart';
import 'navigation_transitions/custom_route.dart';

import 'staggered_interval/staggered_interval_demo.dart';
import 'hero_details/hero_list_page.dart';
import 'animated_list_demo/animated_list_demo_page.dart';
import 'onboarding/onboarding_page.dart';
import 'lottie_switcher_demo/lottie_switcher_page.dart';

class HomeWork26MenuPage extends StatelessWidget {
  const HomeWork26MenuPage({super.key});

  void _open(BuildContext context, Widget page) {
    Navigator.of(context).push(fadeSlideRoute(page)); // custom transition
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Work 26 — Animations')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Конспект HW26'),
            onTap: () => _open(context, const Hw26NotesPage()),
          ),
          const Divider(height: 1),

          ListTile(
            title: const Text('Staggered (Interval) — mini demo'),
            onTap: () => _open(context, const StaggeredIntervalDemoPage()),
          ),
          const Divider(height: 1),

          ListTile(
            title: const Text('Hero: List -> Details + staggered details'),
            subtitle: const Text(
              '2 экрана, hero image + плавное появление деталей',
            ),
            onTap: () => _open(context, const HeroListPage()),
          ),
          const Divider(height: 1),

          ListTile(
            title: const Text('AnimatedList: add/remove'),
            onTap: () => _open(context, const AnimatedListDemoPage()),
          ),
          const Divider(height: 1),

          ListTile(
            title: const Text('Onboarding: PageView + animated dots'),
            onTap: () => _open(context, const OnboardingPage()),
          ),
          const Divider(height: 1),

          ListTile(
            title: const Text(
              'Lottie + AnimatedSwitcher (loading/success + content switch)',
            ),
            onTap: () => _open(context, const LottieSwitcherPage()),
          ),
        ],
      ),
    );
  }
}
