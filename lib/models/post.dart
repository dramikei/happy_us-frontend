import 'package:timeago/timeago.dart' as timeago;

class Post {
  late final String id;
  late final String content;
  late final String heading;
  late final String creatorId;
  late final List<String> likedBy;

  late final String timeAgo;

  Post.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    content = json['content'];
    heading = json['heading'];
    creatorId = json['creatorId'];
    timeAgo = timeago.format(DateTime.parse(json['time']).subtract(
      Duration(hours: 5, minutes: 30),
    ));
    likedBy = (json['likedBy'] as List).cast<String>();
  }
}
