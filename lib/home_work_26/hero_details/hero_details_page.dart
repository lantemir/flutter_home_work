import 'package:flutter/material.dart';

import 'model.dart';
import 'widgets/details_staggered.dart';

class HeroDetailsPage extends StatefulWidget {
  final HeroItem item;
  const HeroDetailsPage({super.key, required this.item});

  @override
  State<HeroDetailsPage> createState() => _HeroDetailsPageState();
}

class _HeroDetailsPageState extends State<HeroDetailsPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    // небольшая задержка, чтобы Hero успел “прилететь”
    Future.microtask(() => _c.forward());
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Hero(
              tag: 'hero_${item.id}',
              child: Image.network(
                item.imageUrl,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          DetailsStaggered(controller: _c),
        ],
      ),
    );
  }
}
