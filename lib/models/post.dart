import 'package:timeago/timeago.dart' as timeago;

class Post {
  late final String id;
  late final String content;
  late final String heading;
  late final DateTime time;
  late final List<String> likedBy;

  late final String timeAgo;

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    heading = json['heading'];

    time = DateTime.parse(json['time']);
    timeAgo = timeago.format(time);

    likedBy = (json['likedBy'] as List).cast<String>();
  }
}
