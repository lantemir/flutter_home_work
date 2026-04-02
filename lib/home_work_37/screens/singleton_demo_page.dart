import 'package:flutter/material.dart';

import '../singleton/logger_service.dart';

class SingletonDemoPage extends StatefulWidget {
  const SingletonDemoPage({super.key});

  @override
  State<SingletonDemoPage> createState() => _SingletonDemoPageState();
}

class _SingletonDemoPageState extends State<SingletonDemoPage> {
  final LoggerService logger = LoggerService();

  @override
  void initState() {
    super.initState();
    logger.log('SingletonDemoPage initState');
  }

  @override
  Widget build(BuildContext context) {
    final logs = logger.logs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Singleton Demo'),
        actions: [
          IconButton(
            onPressed: () {
              logger.clear();
              setState(() {});
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Instance created count: ${LoggerService.instanceCreatedCount}',
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                logger.log('Pressed "Add log" button');
                setState(() {});
              },
              child: const Text('Add log'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: logs.isEmpty
                  ? const Center(child: Text('No logs'))
                  : ListView.builder(
                      itemCount: logs.length,
                      itemBuilder: (_, i) =>
                          Card(child: ListTile(title: Text(logs[i]))),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
