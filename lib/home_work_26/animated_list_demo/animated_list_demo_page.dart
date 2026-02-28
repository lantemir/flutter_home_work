import 'package:flutter/material.dart';

class AnimatedListDemoPage extends StatefulWidget {
  const AnimatedListDemoPage({super.key});

  @override
  State<AnimatedListDemoPage> createState() => _AnimatedListDemoPageState();
}

class _AnimatedListDemoPageState extends State<AnimatedListDemoPage> {
  final _key = GlobalKey<AnimatedListState>();
  final List<int> _items = [];
  int _counter = 0;

  void _add() {
    final index = 0;
    _items.insert(index, _counter++);
    _key.currentState?.insertItem(
      index,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _remove(int index) {
    final removed = _items.removeAt(index);
    _key.currentState?.removeItem(index, (context, animation) {
      final fade = CurvedAnimation(parent: animation, curve: Curves.easeOut);
      return SizeTransition(
        sizeFactor: fade,
        child: FadeTransition(
          opacity: fade,
          child: Card(
            child: ListTile(
              title: Text('Item $removed'),
              subtitle: const Text('removed'),
            ),
          ),
        ),
      );
    }, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedList: add/remove'),
        actions: [IconButton(onPressed: _add, icon: const Icon(Icons.add))],
      ),
      body: AnimatedList(
        key: _key,
        initialItemCount: _items.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index, animation) {
          final item = _items[index];
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );

          return SizeTransition(
            sizeFactor: curved,
            child: FadeTransition(
              opacity: curved,
              child: Card(
                child: ListTile(
                  title: Text('Item $item'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _remove(index),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
