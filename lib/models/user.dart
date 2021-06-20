import 'package:happy_us/models/base_user.dart';
import 'package:happy_us/models/post.dart';

class User extends BaseUser {
  late final List<Post> posts;

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    password = json['password'];
    fcmToken = json['fcmToken'];
    type = userTypeFromString(json['type']);
    age = json['age'];
    social = json['social'];
    posts = (json['posts'] as List)
        .map(
          (post) => Post.fromJson(post),
        )
        .toList();
  }

  User.initialObj() {
    id = "";
    username = "";
    password = "";
    fcmToken = "";
    type = UserType.user;
    age = -1;
    social = {};
    posts = [];
  }
}
