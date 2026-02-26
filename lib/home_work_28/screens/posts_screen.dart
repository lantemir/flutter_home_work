import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../data/post.dart';
import '../data/posts_repository.dart';
import '../dio/error_mapper.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key, required this.repo});
  final PostsRepository repo;

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final CancelToken _cancelToken = CancelToken();

  bool _loading = true;
  String? _error;
  List<Post> _items = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    // ✅ Отмена запроса при уходе со страницы
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel('Page disposed');
    }
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final posts = await widget.repo.fetchPosts(cancelToken: _cancelToken);
      if (!mounted) return;
      setState(() {
        _items = posts;
        _loading = false;
      });
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = mapDioErrorToUserMessage(e);
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Неизвестная ошибка: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HW28 — Dio'),
        actions: [
          IconButton(onPressed: _load, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!, textAlign: TextAlign.center))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (ctx, i) {
                final p = _items[i];
                return ListTile(
                  title: Text(
                    p.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    p.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
    );
  }
}
