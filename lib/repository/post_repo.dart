import 'package:happy_us/models/post.dart';
import 'package:happy_us/utils/globals.dart';

enum UpdateCountEvent { remove, add }

class PostRepo {
  static final _dio = Globals.dio;
  static final _requestHandler = Globals.requestHandler;

  static Future<Post?> createPost({
    required String userId,
    required String content,
    required String heading,
  }) =>
      _requestHandler(_dio.post(
        '/post',
        data: {
          'content': content,
          'heading': heading,
          'creatorId': userId,
          'time': DateTime.now().toString(),
          "likedBy": [],
        },
      ));

  static Future<List<Post>?> getAllPost() =>
      _requestHandler<Post, List<Post>>(_dio.get('/post'));

  static Future<List<Post>?> getUserPosts() =>
      _requestHandler<Post, List<Post>>(_dio.get('/post/user'));

  static Future<bool?> updateLikeCount({
    required String postId,
    required UpdateCountEvent event,
  }) =>
      _requestHandler<bool, bool>(_dio.patch(
        '/post',
        data: {
          'postId': postId,
          'event': event.toString().split('.')[1],
        },
      ));

  static Future<bool?> removePost({
    required String postId,
  }) =>
      _requestHandler<bool, bool>(
        _dio.delete(
          '/post',
          data: {"postId": postId},
        ),
      );
}
