import 'package:flutter/material.dart';

import 'notes_hw38.dart';
import 'presentation/notes_demo_page.dart';

class HomeWork38MenuPage extends StatelessWidget {
  const HomeWork38MenuPage({super.key});

  void _open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Work 38')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Notes demo'),
            subtitle: const Text('Repository + Adapter + Cache'),
            onTap: () => _open(context, const NotesDemoPage()),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Theory / notes'),
            subtitle: const Text('Repository / Adapter / Datasource'),
            onTap: () => _open(context, const Hw38NotesPage()),
          ),
        ],
      ),
    );
  }
}
