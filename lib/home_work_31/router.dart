import 'package:go_router/go_router.dart';
import 'screens/feed_screen.dart';
import 'screens/post_details_screen.dart';
import 'screens/settings_screen.dart';

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/feed/all',
    routes: [
      GoRoute(
        path: '/feed/:filter',
        builder: (context, state) {
          final filter = state.pathParameters['filter']!; // all/cheap/...
          return FeedScreen(filter: filter);
        },
      ),
      GoRoute(
        path: '/post/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return PostDetailsScreen(postId: id);
        },
      ),
      GoRoute(
        path: '/settings/:tab',
        builder: (context, state) {
          final tab = state.pathParameters['tab']!;
          return SettingsScreen(tab: tab);
        },
      ),
    ],
  );
}
