//packages
import 'package:get_it/get_it.dart';

//services
import 'package:flickd/services/http_services.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HttpServices _http;

  MovieService() {
    _http = getIt.get<HttpServices>();
  }
}
