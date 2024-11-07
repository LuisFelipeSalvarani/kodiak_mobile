import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';

class DioClient {
  static Dio? _dio;

  static Future<Dio> getInstance() async {
    if (_dio != null) return _dio!;

    var appDocDir = await getApplicationDocumentsDirectory();
    var cookieJar =
        PersistCookieJar(storage: FileStorage("${appDocDir.path}/cookies"));

    _dio = Dio()
      ..options.baseUrl = dotenv.env['API_URL'] ?? ''
      ..interceptors.add(CookieManager(cookieJar))
      ..options.connectTimeout = const Duration(milliseconds: 5000)
      ..options.receiveTimeout = const Duration(milliseconds: 5000);

    return _dio!;
  }
}
