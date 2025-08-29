import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;
  late final String baseUrl;

  factory DioClient() {
    return _instance;
  }
// ! como reponder correctamente me aparecia error en el provider uando no era eso si no
  // ! el .env condotenv, un theo con mensaje me parece
  DioClient._internal() {
    final url = dotenv.env['API_URL'];
    if (url == "" || url == null) {
      throw Exception("environment variabe API_URL is not set");
    }
    baseUrl = url;
    dio = Dio(BaseOptions(
      validateStatus: (status) => status != null && status >= 200 && status <= 500,
    ));
  }
}
