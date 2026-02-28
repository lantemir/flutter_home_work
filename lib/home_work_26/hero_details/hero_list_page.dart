import 'package:flutter/material.dart';

import '../navigation_transitions/custom_route.dart';
import 'hero_details_page.dart';
import 'model.dart';
import 'widgets/hero_card.dart';

class HeroListPage extends StatelessWidget {
  const HeroListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero List')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: demoItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final item = demoItems[i];
          return HeroCard(
            item: item,
            onTap: () => Navigator.of(context).push(
              fadeSlideRoute(
                HeroDetailsPage(item: item),
              ), // custom transition + hero
            ),
          );
        },
      ),
    );
  }
}
