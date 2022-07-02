import 'package:fake_weather_app/data/datasources/remote_datasource.dart';
import 'package:fake_weather_app/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  WeatherRepository,
  RemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}