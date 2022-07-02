import 'package:dartz/dartz.dart';
import 'package:fake_weather_app/domain/entities/weather.dart';
import 'package:fake_weather_app/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetCurrentWeather usecase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetCurrentWeather(mockWeatherRepository);
  });

  const testWeather = Weather(
    cityName: 'Teresina',
    main: 'Clouds',
    description: 'few clouds',
    temperature: 302.28,
  );

  const tCityName = 'Teresina';

  test(
    'deve obter detalhes meteorológicos atuais do repositório',
    () async {
      when(mockWeatherRepository.getCurrentWeather(tCityName))
          .thenAnswer((_) async => const Right(testWeather));

      final result = await usecase.execute(tCityName);

      expect(result, const Right(testWeather));
    },
  );
}