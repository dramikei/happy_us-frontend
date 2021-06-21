import 'package:get/get.dart';
import 'package:happy_us/models/post.dart';
import 'package:happy_us/repository/post_repo.dart';

class PostController extends GetxController {
  RxList<Post> posts = <Post>[].obs;

  void insertPosts(List<Post> fetchedPosts) {
    posts.value = fetchedPosts;
  }

  bool isLiked({
    required String postId,
    required String userId,
  }) {
    for (int i = 0; i < posts.length; i++) {
      if (posts[i].id == postId && posts[i].likedBy.contains(userId)) {
        return true;
      }
    }
    return false;
  }

  void updateLike({
    required String postId,
    required String userId,
    required UpdateCountEvent event,
  }) {
    for (int i = 0; i < posts.length; i++) {
      if (posts[i].id == postId) {
        if (event == UpdateCountEvent.add)
          posts[i].likedBy.add(userId);
        else
          posts[i].likedBy.remove(userId);
        break;
      }
    }
  }
}
