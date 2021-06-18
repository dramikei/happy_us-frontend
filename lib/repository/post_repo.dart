import 'package:happy_us/models/post.dart';
import 'package:happy_us/utils/instances.dart';

enum UpdateCountEvent { remove, add }

class PostRepo {
  static final _dio = Instances.dio;

  static Future<Post?> createPost({
    required String content,
    required String header,
  }) async {
    // await _dio.post(
    //   '/post',
    //   data: {
    //     'content': content,
    //     'header': header,
    //     'creatorId': Instances.userId,
    //     'time': DateTime.now().toString(),
    //     "likedBy": [],
    //   },
    // );
    return null;
  }

  static Future<List<Post>> getAllPost() async {
    return [];
  }

  static Future<List<Post>> getUserPosts() async {
    return [];
  }

  static Future<bool> updateLikeCount({
    required String postId,
    required UpdateCountEvent event,
  }) async {
    return true;
  }

  static Future<bool> removePost({
    required String postId,
  }) async {
    return true;
  }
}
