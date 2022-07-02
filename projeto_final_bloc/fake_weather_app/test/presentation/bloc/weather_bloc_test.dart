import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_weather_app/core/errors/failure.dart';
import 'package:fake_weather_app/domain/entities/weather.dart';
import 'package:fake_weather_app/domain/usecases/get_current_weather.dart';
import 'package:fake_weather_app/presentation/bloc/weather_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_bloc_test.mocks.dart';

@GenerateMocks([GetCurrentWeather])
void main() {
  late MockGetCurrentWeather mockGetCurrentWeather;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeather = MockGetCurrentWeather();
    weatherBloc = WeatherBloc(mockGetCurrentWeather);
  });

  const tWeather = Weather(
    cityName: 'Teresina',
    main: 'Clouds',
    description: 'few clouds',
    temperature: 302.28,
  );

  const tCityName = 'Teresina';

  test(
    'estado inicial deve estar vazio',
    () {
      expect(weatherBloc.state, WeatherEmpty());
    },
  );

  blocTest<WeatherBloc, WeatherState>(
    'deve emitir [carregando, tem dados] quando os dados são obtidos com sucesso',
    build: () {
      when(mockGetCurrentWeather.execute(tCityName))
          .thenAnswer((_) async => const Right(tWeather));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(tCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherHasData(tWeather),
    ],
    verify: (bloc) {
      verify(mockGetCurrentWeather.execute(tCityName));
    },
  );

  blocTest<WeatherBloc, WeatherState>(
    'deve emitir [carregando, erro] quando a obtenção de dados não for bem-sucedida',
    build: () {
      when(mockGetCurrentWeather.execute(tCityName))
          .thenAnswer((_) async => const Left(ServerFailure('Server failure')));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(tCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherError('Server failure'),
    ],
    verify: (bloc) {
      verify(mockGetCurrentWeather.execute(tCityName));
    },
  );
}