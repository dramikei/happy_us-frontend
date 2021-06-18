import 'package:happy_us/models/volunteer.dart';
import 'package:happy_us/utils/globals.dart';

class VolunteerRepo {
  static final _dio = Globals.dio;
  static final _requestHandler = Globals.requestHandler;
  static final _listRequestHandler = Globals.listRequestHandler;

  static Future<List<Volunteer>?> getAllVolunteers() =>
      _listRequestHandler<Volunteer>(_dio.get('/volunteer'));
}
