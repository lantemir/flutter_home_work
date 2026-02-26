import 'package:dio/dio.dart';
import 'post.dart';

class PostsRepository {
  PostsRepository(this._dio);

  final Dio _dio;

  Future<List<Post>> fetchPosts({CancelToken? cancelToken}) async {
    final res = await _dio.get('/posts', cancelToken: cancelToken);
    final data = res.data as List<dynamic>;
    return data.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Post> fetchPost(int id, {CancelToken? cancelToken}) async {
    final res = await _dio.get('/posts/$id', cancelToken: cancelToken);
    return Post.fromJson(res.data as Map<String, dynamic>);
  }

  /// Optional: download demo (onReceiveProgress)
  Future<void> downloadSomething({
    required String savePath,
    required void Function(int received, int total) onProgress,
    CancelToken? cancelToken,
  }) async {
    await _dio.download(
      'https://speed.hetzner.de/100MB.bin',
      savePath,
      cancelToken: cancelToken,
      onReceiveProgress: onProgress,
    );
  }
}
