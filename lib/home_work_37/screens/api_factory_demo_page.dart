import 'package:flutter/material.dart';

import '../factory/api_models.dart';
import '../factory/api_response_factory.dart';
import '../singleton/logger_service.dart';

class ApiFactoryDemoPage extends StatefulWidget {
  const ApiFactoryDemoPage({super.key});

  @override
  State<ApiFactoryDemoPage> createState() => _ApiFactoryDemoPageState();
}

class _ApiFactoryDemoPageState extends State<ApiFactoryDemoPage> {
  ApiItem? currentItem;
  final logger = LoggerService();

  void _parseUser() {
    final json = {
      'id': '1',
      'type': 'user',
      'name': 'Temir',
      'email': 'temir@mail.com',
    };

    currentItem = ApiResponseFactory.parse(json);
    logger.log('Parsed user response');
    setState(() {});
  }

  void _parseProduct() {
    final json = {
      'id': '2',
      'type': 'product',
      'title': 'Laptop',
      'price': 999.99,
    };

    currentItem = ApiResponseFactory.parse(json);
    logger.log('Parsed product response');
    setState(() {});
  }

  void _parseUnknown() {
    final json = {'id': '3', 'type': 'other', 'value': '???'};

    currentItem = ApiResponseFactory.parse(json);
    logger.log('Parsed unknown response');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String text = 'No parsed data';

    final item = currentItem;
    if (item is UserItem) {
      text =
          'UserItem\nid: ${item.id}\nname: ${item.name}\nemail: ${item.email}';
    } else if (item is ProductItem) {
      text =
          'ProductItem\nid: ${item.id}\ntitle: ${item.title}\nprice: ${item.price}';
    } else if (item is UnknownItem) {
      text = 'UnknownItem\nid: ${item.id}\nraw: ${item.raw}';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Factory: API Parser')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _parseUser,
                  child: const Text('Parse User'),
                ),
                ElevatedButton(
                  onPressed: _parseProduct,
                  child: const Text('Parse Product'),
                ),
                ElevatedButton(
                  onPressed: _parseUnknown,
                  child: const Text('Parse Unknown'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: Text(text, style: const TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
