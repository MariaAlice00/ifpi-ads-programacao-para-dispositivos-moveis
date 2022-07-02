import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fake_weather_app/core/errors/exception.dart';
import 'package:fake_weather_app/core/errors/failure.dart';
import 'package:fake_weather_app/data/models/weather_model.dart';
import 'package:fake_weather_app/data/repositories/weather_repository_impl.dart';
import 'package:fake_weather_app/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late WeatherRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = WeatherRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

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

  group('obter o clima atual', () {
    const tCityName = 'Teresina';

    test(
      'deve retornar o clima atual quando uma chamada para a fonte de dados for bem-sucedida',
      () async {
        when(mockRemoteDataSource.getCurrentWeather(tCityName))
            .thenAnswer((_) async => tWeatherModel);
        final result = await repository.getCurrentWeather(tCityName);
        verify(mockRemoteDataSource.getCurrentWeather(tCityName));
        expect(result, equals(const Right(tWeather)));
      },
    );

    test(
      'deve retornar a falha do servidor quando uma chamada para a fonte de dados não for bem-sucedida',
      () async {
        when(mockRemoteDataSource.getCurrentWeather(tCityName))
            .thenThrow(ServerException());
        final result = await repository.getCurrentWeather(tCityName);
        verify(mockRemoteDataSource.getCurrentWeather(tCityName));
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'deve retornar falha de conexão quando o dispositivo não tem internet',
      () async {
        when(mockRemoteDataSource.getCurrentWeather(tCityName)).thenThrow(
            const SocketException('Failed to connect to the network'));
        final result = await repository.getCurrentWeather(tCityName);
        verify(mockRemoteDataSource.getCurrentWeather(tCityName));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
}
