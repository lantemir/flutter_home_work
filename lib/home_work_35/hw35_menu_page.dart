import 'package:flutter/material.dart';

import 'layers_diagram_page.dart';
import 'mvc/task_mvc_page.dart';
import 'mvp/task_mvp_page.dart';
import 'notes_hw35.dart';

class HomeWork35MenuPage extends StatelessWidget {
  const HomeWork35MenuPage({super.key});

  void _open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Work 35 — MVC / MVP')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('MVC version'),
            subtitle: const Text('Tasks screen in MVC style'),
            onTap: () => _open(context, const TaskMvcPage()),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('MVP version'),
            subtitle: const Text('Tasks screen in MVP style'),
            onTap: () => _open(context, const TaskMvpPage()),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Layers diagram'),
            subtitle: const Text('Responsibilities by layers'),
            onTap: () => _open(context, const LayersDiagramPage()),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Notes / comparison'),
            subtitle: const Text('MVC vs MVP summary'),
            onTap: () => _open(context, const Hw35NotesPage()),
          ),
        ],
      ),
    );
  }
}
