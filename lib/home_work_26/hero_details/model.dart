class HeroItem {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;

  const HeroItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

const demoItems = <HeroItem>[
  HeroItem(
    id: '1',
    title: 'Mountain',
    subtitle: 'Cool place to visit',
    imageUrl: 'https://picsum.photos/id/1018/600/400',
  ),
  HeroItem(
    id: '2',
    title: 'Forest',
    subtitle: 'Fresh air & calm',
    imageUrl: 'https://picsum.photos/id/1011/600/400',
  ),
  HeroItem(
    id: '3',
    title: 'City',
    subtitle: 'Night lights',
    imageUrl: 'https://picsum.photos/id/1015/600/400',
  ),
];
