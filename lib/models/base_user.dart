enum _UserType { user, volunteer }

abstract class BaseUser {
  late final String id;
  late final String username;
  late final String password;
  late final String fcmToken;
  late final _UserType type;
  late final int age;
  late final Map<String, dynamic> social;

  String get userTypeAsString {
    switch (type) {
      case _UserType.user:
        return 'user';
      case _UserType.volunteer:
        return 'volunteer';
    }
  }

  _UserType userTypeFromString(String type) {
    switch (type) {
      case 'user':
        return _UserType.user;
      case 'volunteer':
        return _UserType.volunteer;
      default:
        return _UserType.user;
    }
  }
}
