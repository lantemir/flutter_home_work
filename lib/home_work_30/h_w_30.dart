// UI экран
import 'package:flutter/material.dart';

import 'di/locator.dart';
import 'dom/usecase.dart';
import 'dom/model_app.dart';

class HomeWork30Screen extends StatefulWidget {
  const HomeWork30Screen({super.key, required this.useCase});

  // ✅ Получение из get_it через фабрику (задание: "через конструктор/фабрику")
  factory HomeWork30Screen.fromDI() {
    return HomeWork30Screen(useCase: getIt<GetGroceriesUseCase>());
  }

  final GetGroceriesUseCase useCase;

  @override
  State<HomeWork30Screen> createState() => _HomeWork30ScreenState();
}

class _HomeWork30ScreenState extends State<HomeWork30Screen> {
  late Future<List<GroceryItemModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.useCase();
  }

  void _reload() {
    setState(() {
      _future = widget.useCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HW30 — get_it DI'),
        actions: [
          IconButton(onPressed: _reload, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder<List<GroceryItemModel>>(
        future: _future,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }
          final items = snapshot.data ?? const <GroceryItemModel>[];
          if (items.isEmpty) {
            return const Center(child: Text('Empty list'));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, i) {
              final item = items[i];
              return ListTile(
                title: Text(item.name),
                trailing: Text(item.quantity.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
