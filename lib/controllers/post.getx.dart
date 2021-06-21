import 'package:get/get.dart';
import 'package:happy_us/models/post.dart';
import 'package:happy_us/repository/post_repo.dart';

class PostController extends GetxController {
  RxList<Post> posts = <Post>[].obs;

  void insertPosts(List<Post> fetchedPosts) {
    posts.value = fetchedPosts;
  }

  bool isLiked({required String postId, required String userId}) {
    // ignore: invalid_use_of_protected_member
    final values = posts.value;

    for (int i = 0; i < values.length; i++) {
      if (values[i].id == postId && values[i].likedBy.contains(userId)) {
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
    // ignore: invalid_use_of_protected_member
    final values = posts.value;

    for (int i = 0; i < values.length; i++) {
      if (values[i].id == postId) {
        if (event == UpdateCountEvent.add)
          // ignore: invalid_use_of_protected_member
          posts.value[i].likedBy.add(userId);
        else
          // ignore: invalid_use_of_protected_member
          posts.value[i].likedBy.remove(userId);
        break;
      }
    }
  }
}
