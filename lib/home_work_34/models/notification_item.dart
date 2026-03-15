class NotificationItem {
  final String? title;
  final String? body;
  final String? itemId;
  final String? route;
  final Map<String, dynamic> rawData;

  const NotificationItem({
    required this.title,
    required this.body,
    required this.itemId,
    required this.route,
    required this.rawData,
  });

  factory NotificationItem.fromMessage({
    required String? title,
    required String? body,
    required Map<String, dynamic> data,
  }) {
    return NotificationItem(
      title: title,
      body: body,
      itemId: data['itemId']?.toString(),
      route: data['route']?.toString(),
      rawData: data,
    );
  }
}
