import 'dart:convert';

import 'package:fake_weather_app/data/models/weather_model.dart';
import 'package:fake_weather_app/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json/json_reader.dart';

void main() {
  const tWeatherModel = WeatherModel(
    cityName: 'Teresina',
    main: 'Clouds',
    description: 'few clouds',
    temperature: 302.28,
  );

  const tWeather = Weather(
    cityName: 'Teresina',
    main: 'Clouds',
    description: 'few clouds',
    temperature: 302.28,
  );

  group('entity', () {
    test(
      'deve ser uma subclasse de entidade meteorológica',
      () async {
        final result = tWeatherModel.toEntity();
        expect(result, equals(tWeather));
      },
    );
  });

  group('from json', () {
    test(
      'deve retornar um modelo válido do json',
      () async {
        final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/json/weather.json'),
        );
        final result = WeatherModel.fromJson(jsonMap);
        expect(result, equals(tWeatherModel));
      },
    );
  });

  group('to json', () {
    test(
      'deve retornar um json map contendo dados adequados',
      () async {
        final result = tWeatherModel.toJson();
        final expectedJsonMap = {
          "weather": [
          {
              "main": "Clouds",
              "description": "few clouds"
          }
          ],
          "main": {
              "temp": 302.28
          },
          "name": "Teresina"
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}