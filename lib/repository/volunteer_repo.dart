import 'package:happy_us/models/volunteer.dart';
import 'package:happy_us/utils/instances.dart';

class VolunteerRepo {
  static final _dio = Instances.dio;

  static Future<List<Volunteer>> getAllVolunteers() async {
    return [];
  }
}
