import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../hw31_app.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.tab});

  final String tab;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _token;
  final _controller = TextEditingController(text: 'demo_token_123');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadToken() async {
    final scope = Hw31Scope.of(context);
    final t = await scope.tokenStorage.readToken();
    setState(() => _token = t);
  }

  Future<void> _saveToken() async {
    final scope = Hw31Scope.of(context);
    await scope.tokenStorage.saveToken(_controller.text.trim());
    await _loadToken();
  }

  Future<void> _deleteToken() async {
    final scope = Hw31Scope.of(context);
    await scope.tokenStorage.deleteToken();
    await _loadToken();
  }

  @override
  Widget build(BuildContext context) {
    final scope = Hw31Scope.of(context);
    final isRu = scope.locale.value.languageCode == 'ru';

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings (${widget.tab})'),
        actions: [
          IconButton(
            onPressed: () => context.go('/feed/all'),
            icon: const Icon(Icons.list),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Locale', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            children: [
              ElevatedButton(
                onPressed: () => scope.locale.value = const Locale('en'),
                child: const Text('EN'),
              ),
              ElevatedButton(
                onPressed: () => scope.locale.value = const Locale('ru'),
                child: const Text('RU'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Text(
            'Secure token demo',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Token',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ElevatedButton(onPressed: _saveToken, child: const Text('Save')),
              OutlinedButton(onPressed: _loadToken, child: const Text('Read')),
              TextButton(onPressed: _deleteToken, child: const Text('Delete')),
            ],
          ),
          const SizedBox(height: 12),
          Text('Stored token: ${_token ?? "(null)"}'),

          const SizedBox(height: 24),
          Text('Route tabs', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            children: [
              OutlinedButton(
                onPressed: () => context.go('/settings/general'),
                child: const Text('general'),
              ),
              OutlinedButton(
                onPressed: () => context.go('/settings/security'),
                child: const Text('security'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Current tab param: ${widget.tab}'),
        ],
      ),
    );
  }
}
