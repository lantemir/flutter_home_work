import 'package:flutter/material.dart';

import '../factory/status_type.dart';
import '../factory/status_widget_factory.dart';
import '../singleton/logger_service.dart';

class StatusFactoryDemoPage extends StatefulWidget {
  const StatusFactoryDemoPage({super.key});

  @override
  State<StatusFactoryDemoPage> createState() => _StatusFactoryDemoPageState();
}

class _StatusFactoryDemoPageState extends State<StatusFactoryDemoPage> {
  StatusType _current = StatusType.loading;
  final logger = LoggerService();

  @override
  void initState() {
    super.initState();
    logger.log('StatusFactoryDemoPage opened');
  }

  @override
  Widget build(BuildContext context) {
    Widget statusWidget;

    switch (_current) {
      case StatusType.loading:
        statusWidget = StatusWidgetFactory.create(StatusType.loading);
        break;
      case StatusType.success:
        statusWidget = StatusWidgetFactory.create(
          StatusType.success,
          message: 'Data loaded successfully',
        );
        break;
      case StatusType.error:
        statusWidget = StatusWidgetFactory.create(
          StatusType.error,
          message: 'Failed to load data',
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Factory: Status Widgets')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {
                    logger.log('Status changed to loading');
                    setState(() => _current = StatusType.loading);
                  },
                  child: const Text('Loading'),
                ),
                ElevatedButton(
                  onPressed: () {
                    logger.log('Status changed to success');
                    setState(() => _current = StatusType.success);
                  },
                  child: const Text('Success'),
                ),
                ElevatedButton(
                  onPressed: () {
                    logger.log('Status changed to error');
                    setState(() => _current = StatusType.error);
                  },
                  child: const Text('Error'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Expanded(child: Center(child: statusWidget)),
          ],
        ),
      ),
    );
  }
}
