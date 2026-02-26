import 'package:flutter/material.dart';
import 'dio/api_client.dart';
import 'data/posts_repository.dart';
import 'screens/posts_screen.dart';

class HomeWork28 extends StatelessWidget {
  const HomeWork28({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = createDioClient();
    final repo = PostsRepository(dio);

    return PostsScreen(repo: repo);
  }
}
