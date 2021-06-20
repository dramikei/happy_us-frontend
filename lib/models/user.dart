import 'package:happy_us/models/base_user.dart';

class User extends BaseUser {
  late final List<String> postIds;

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    fcmToken = json['fcmToken'];
    type = UserType.user;
    age = json['age'];
    social = json['social'];
    postIds = (json['posts'] as List).cast<String>();
  }

  User.initialObj() {
    id = "";
    username = "";
    fcmToken = "";
    type = UserType.user;
    age = -1;
    social = {};
    postIds = [];
  }
}
