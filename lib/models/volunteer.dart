import 'package:happy_us/models/base_user.dart';

class Volunteer extends BaseUser {
  late final List<String> hobbies;
  late final String aboutMe;
  late final String imageUrl;

  Volunteer.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    username = json['username'];
    fcmToken = json['fcmToken'];
    type = UserType.volunteer;
    age = json['age'];
    social = json['social'];
    hobbies = (json['hobbies'] as List).cast<String>();
    aboutMe = json['aboutMe'];
    imageUrl = json['imageUrl'];
  }
}
