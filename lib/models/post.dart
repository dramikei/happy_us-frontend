class Post {
  late final String id;
  late final String content;
  late final String heading;
  late final DateTime time;
  late final List<_PostComment> comments;

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    heading = json['heading'];
    time = DateTime.parse(json['time']);
    comments = (json['comments'] as List)
        .map((comment) => _PostComment.fromJson(comment))
        .toList();
  }
}

class _PostComment {
  late final String id;
  late final String message;
  late final String username;

  _PostComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    username = json['username'];
  }
}
