import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/dummy_posts.dart';
import '../hw31_app.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context) {
    final scope = Hw31Scope.of(context);
    final locale = scope.locale.value;
    final dateLocale = locale.languageCode == 'ru' ? 'ru_RU' : 'en_US';
    final currencyLocale = locale.languageCode == 'ru' ? 'ru_RU' : 'en_US';
    final money = NumberFormat.simpleCurrency(
      locale: currencyLocale,
      name: 'KZT',
    );

    final post = dummyPosts.where((p) => p.id == postId).firstOrNull;

    if (post == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Details')),
        body: const Center(child: Text('Post not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Post #${post.id}')),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: post.imageUrl,
            height: 240,
            fit: BoxFit.cover,
            placeholder: (_, __) => const SizedBox(
              height: 240,
              child: Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (_, __, ___) => const SizedBox(
              height: 240,
              child: Center(child: Icon(Icons.broken_image)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              post.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Created: ${DateFormat('dd MMM yyyy', dateLocale).format(post.createdAt)}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Price: ${money.format(post.price)}'),
          ),
        ],
      ),
    );
  }
}

/// маленький helper: firstOrNull
extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
