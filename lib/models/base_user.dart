enum UserType { user, volunteer }

abstract class BaseUser {
  late final String id;
  late final String username;
  late final String password;
  late final String fcmToken;
  late final UserType type;
  late final int age;
  late final Map<String, dynamic> social;

  String get userTypeAsString {
    switch (type) {
      case UserType.user:
        return 'user';
      case UserType.volunteer:
        return 'volunteer';
    }
  }

  UserType userTypeFromString(String type) {
    switch (type) {
      case 'user':
        return UserType.user;
      case 'volunteer':
        return UserType.volunteer;
      default:
        return UserType.user;
    }
  }
}
