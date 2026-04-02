import 'package:flutter/material.dart';

import 'notes_hw37.dart';
import 'screens/api_factory_demo_page.dart';
import 'screens/singleton_demo_page.dart';
import 'screens/status_factory_demo_page.dart';

class HomeWork37MenuPage extends StatelessWidget {
  const HomeWork37MenuPage({super.key});

  void _open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Work 37 — Patterns')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Singleton demo'),
            subtitle: const Text('LoggerService used in app'),
            onTap: () => _open(context, const SingletonDemoPage()),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Factory: status widgets'),
            subtitle: const Text('loading / success / error by enum'),
            onTap: () => _open(context, const StatusFactoryDemoPage()),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Factory: API parser'),
            subtitle: const Text('Parse responses by type'),
            onTap: () => _open(context, const ApiFactoryDemoPage()),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Notes / comparison'),
            subtitle: const Text('Singleton vs get_it'),
            onTap: () => _open(context, const Hw37NotesPage()),
          ),
        ],
      ),
    );
  }
}
