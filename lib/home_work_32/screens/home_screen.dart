import 'package:flutter/material.dart';
import '../auth/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.auth});
  final AuthService auth;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _name = TextEditingController();
  final _photo = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose();
    _photo.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() => _loading = true);
    await widget.auth.updateProfile(
      displayName: _name.text.isEmpty ? null : _name.text,
      photoUrl: _photo.text.isEmpty ? null : _photo.text,
    );
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: _loading ? null : widget.auth.signOut,
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: user == null
            ? const Text('No user')
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('UID: ${user.uid}'),
                  const SizedBox(height: 8),
                  Text('Email: ${user.email}'),
                  const SizedBox(height: 8),
                  Text('DisplayName: ${user.displayName ?? "(null)"}'),
                  const SizedBox(height: 8),
                  Text('PhotoURL: ${user.photoURL ?? "(null)"}'),
                  const Divider(height: 32),

                  TextField(
                    controller: _name,
                    decoration: const InputDecoration(
                      labelText: 'New displayName',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _photo,
                    decoration: const InputDecoration(
                      labelText: 'New photoURL (link)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _loading ? null : _saveProfile,
                    child: _loading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Save profile'),
                  ),
                ],
              ),
      ),
    );
  }
}
