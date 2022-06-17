import 'package:clean_art/data/datasources/remote_data_sources.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:clean_art/domain/repositories/weather_repository.dart';

@GenerateMocks(
  [WeatherRepository, RemoteDataSource],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
