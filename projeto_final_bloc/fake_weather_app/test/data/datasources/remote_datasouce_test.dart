import 'dart:convert';
import 'package:fake_weather_app/core/constants.dart';
import 'package:fake_weather_app/core/errors/exception.dart';
import 'package:fake_weather_app/data/datasources/remote_datasource.dart';
import 'package:fake_weather_app/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/json/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);
  });

  group('obter o clima atual', () {
    const tCityName = 'Teresina';
    final tWeatherModel = WeatherModel.fromJson(json
        .decode(readJson('helpers/json/weather.json')));

    test(
      'deve retornar o modelo climático quando o código de resposta for 200',
      () async {
        when(
          mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(tCityName))),
        ).thenAnswer(
          (_) async => http.Response(
              readJson('helpers/json/weather.json'), 200),
        );

        final result = await dataSource.getCurrentWeather(tCityName);

        expect(result, equals(tWeatherModel));
      },
    );

    test(
      'deve lançar uma server exception quando o código de resposta for 404 ou outro',
      () async {
        when(
          mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(tCityName))),
        ).thenAnswer(
          (_) async => http.Response('Not found', 404),
        );

        final call = dataSource.getCurrentWeather(tCityName);

        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}