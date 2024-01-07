import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

//models
import 'package:flickd/models/app_config.dart';

class HttpServices {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  late String _baseUrl;
  late String _apiKey;

  httpService() {
    AppConfig config = getIt.get<AppConfig>();
    _baseUrl = config.BASE_API_URL;
    _apiKey = config.API_KEY;
  }

  Future<Response?> get(String path, {Map<String, dynamic>? query}) async {
    try {
      String url = '$_baseUrl$path';

      Map<String, dynamic> _query = {
        'api_key': _apiKey,
        'language': 'en-US',
      };
      if (query != null) {
        _query.addAll(query);
      }
      return await dio.get(url, queryParameters: _query);
    } catch (e) {
      print('unable to perfom get request.');
      print('DioError: $e');
    }
  }
}
