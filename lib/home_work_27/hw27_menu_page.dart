import 'package:flutter/material.dart';

import 'counter_history/counter_page.dart';
import 'login_form/login_page.dart';
import 'data_loader/data_page.dart';

class HomeWork27MenuPage extends StatelessWidget {
  const HomeWork27MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Work 27 — flutter_bloc')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Cubit: Counter + History (last 10) + Clear'),
            subtitle: const Text('Маленькие виджеты + BlocSelector точечно'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CounterHistoryPage()),
            ),
          ),
          const Divider(height: 1),

          ListTile(
            title: const Text(
              'Bloc: Login form (validation + loading/success/error)',
            ),
            subtitle: const Text('Listener для Snackbar, Selector точечно'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LoginFormPage()),
            ),
          ),
          const Divider(height: 1),

          ListTile(
            title: const Text(
              'Практика: Data Loader (loading/success/error + retry)',
            ),
            subtitle: const Text('Пустой список / длинный текст / ошибка'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DataLoaderPage()),
            ),
          ),
        ],
      ),
    );
  }
}
