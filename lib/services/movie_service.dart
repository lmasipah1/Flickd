import 'package:flickd/services/http_services.dart';
import 'package:get_it/get_it.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HttpServices _http;

  MovieService() {
    _http = getIt.get<HttpServices>();
  }
}
