import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../data/dummy_posts.dart';
import '../data/post_dto.dart';
import '../hw31_app.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key, required this.filter});

  final String filter;

  @override
  Widget build(BuildContext context) {
    final scope = Hw31Scope.of(context);
    final locale = scope.locale.value;

    // Пример фильтра: cheap показывает товары дешевле 8000
    final List<PostDto> items = switch (filter) {
      'cheap' => dummyPosts.where((p) => p.price < 8000).toList(),
      _ => dummyPosts,
    };

    // intl форматирование под locale
    final dateLocale = locale.languageCode == 'ru' ? 'ru_RU' : 'en_US';
    final currencyLocale = locale.languageCode == 'ru' ? 'ru_RU' : 'en_US';
    final money = NumberFormat.simpleCurrency(
      locale: currencyLocale,
      name: 'KZT',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Feed ($filter)'),
        actions: [
          IconButton(
            onPressed: () => context.go('/settings/general'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text('Empty list for this filter'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i) {
                final p = items[i];
                final formattedDate = DateFormat(
                  'dd MMM yyyy',
                  dateLocale,
                ).format(p.createdAt);
                final formattedPrice = money.format(p.price);

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: InkWell(
                    onTap: () => context.go('/post/${p.id}'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // cached_network_image: кэш + placeholder + errorWidget
                        CachedNetworkImage(
                          imageUrl: p.imageUrl,
                          height: 180,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const SizedBox(
                            height: 180,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => const SizedBox(
                            height: 180,
                            child: Center(child: Icon(Icons.broken_image)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  p.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(formattedPrice),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            bottom: 12,
                          ),
                          child: Text('Created: $formattedDate'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          children: [
            OutlinedButton(
              onPressed: () => context.go('/feed/all'),
              child: const Text('all'),
            ),
            OutlinedButton(
              onPressed: () => context.go('/feed/cheap'),
              child: const Text('cheap'),
            ),
          ],
        ),
      ),
    );
  }
}
