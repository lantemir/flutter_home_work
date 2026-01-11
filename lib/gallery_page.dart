import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localImages = [
      'assets/images/pic1.jpg',
      'assets/images/pic1.jpg',
      'assets/images/pic1.jpg',
    ];

    //Сетевые картинки
    final networkImages = [
      'https://picsum.photos/id/10/600/600',
      'https://picsum.photos/id/20/600/600',
      'https://picsum.photos/id/30/600/600',
      'https://picsum.photos/id/40/600/600',
    ];

    final gallery = <_GalleryItem>[
      ...localImages.map((p) => _GalleryItem.local(p)),
      ...networkImages.map((u) => _GalleryItem.network(u)),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Images & Gallery'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(
                  Icons.image,
                  size: 34,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Пример изображений',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),

            //2) Локальное изображение
            Text(
              'Локальное изображение',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/pic1.jpg',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            //3) Сетевое изображение
            Text(
              'Сетевое изображение',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://picsum.photos/900/500',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                //лоадер и ексепшн
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return SizedBox(
                    height: 180,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: progress.expectedTotalBytes == null
                            ? null
                            : progress.cumulativeBytesLoaded /
                                  progress.expectedTotalBytes!,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, StackTrace) {
                  return const SizedBox(
                    height: 180,
                    child: Center(
                      child: Text('Не удалось загрузить изображение'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // 4) Галерея GridView.count
            Text(
              'Галерея (GridView)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [for (final item in gallery) _GalleryTile(item: item)],
            ),
          ],
        ),
      ),
    );
  }
}

class _GalleryTile extends StatelessWidget {
  const _GalleryTile({required this.item});

  final _GalleryItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140, // фикс высота ячейки
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      clipBehavior: Clip.antiAlias,
      child: item.isLocal
          ? Image.asset(item.value, fit: BoxFit.cover)
          : Image.network(item.value, fit: BoxFit.cover),
    );
  }
}

class _GalleryItem {
  _GalleryItem._(this.value, this.isLocal);

  final String value;
  final bool isLocal;

  factory _GalleryItem.local(String path) => _GalleryItem._(path, true);
  factory _GalleryItem.network(String url) => _GalleryItem._(url, false);
}
