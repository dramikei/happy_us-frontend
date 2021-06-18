class Notification {
  late final String userId;
  late final String redirectTo;
  late final String title;
  late final String description;
  late final bool seen;
  late final DateTime time;

  Notification.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    redirectTo = json['redirectTo'];
    title = json['title'];
    description = json['description'];
    seen = json['seen'];
    time = DateTime.parse(json['time']);
  }
}
