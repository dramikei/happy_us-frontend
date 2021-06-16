import 'package:happy_us/utils/instances.dart';

class PostRepo {
  static final _dio = Instances.dio;

  static Future createPost() async {
    final r = await _dio.get('/ping');
    return r;
  }
}
