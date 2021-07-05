class Notification {
  late final String id;
  late final String userId;
  late final String redirectTo;
  late final String title;
  late final String description;
  late bool seen;
  late final DateTime time;

  Notification.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['_id'];
    redirectTo = json['redirectTo'];
    title = json['title'];
    description = json['description'];
    seen = json['seen'];
    time = DateTime.parse(json['time']);
  }
}
