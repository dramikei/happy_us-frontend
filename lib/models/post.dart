import 'package:timeago/timeago.dart' as timeago;

class Post {
  late final String id;
  late final String content;
  late final String heading;
  late final String creatorId;
  late final DateTime _time;
  late final List<String> likedBy;

  late final String timeAgo;

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    heading = json['heading'];
    creatorId = json['creatorId'];
    _time = DateTime.parse(json['time']);
    timeAgo = timeago.format(_time);
    likedBy = (json['likedBy'] as List).cast<String>();
  }
}
