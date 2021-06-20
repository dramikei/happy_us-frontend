import 'package:happy_us/models/volunteer.dart';
import 'package:happy_us/utils/globals.dart';

class VolunteerRepo {
  static final _dio = Globals.dio;
  static final _requestHandler = Globals.requestHandler;

  static Future<Volunteer?> getLoggedInVolunteer() =>
      _requestHandler<Volunteer, Volunteer>(_dio.get('/volunteer'));

  static Future<List<Volunteer>?> getAllVolunteers() =>
      _requestHandler<Volunteer, List<Volunteer>>(_dio.get('/volunteer/all'));
}
