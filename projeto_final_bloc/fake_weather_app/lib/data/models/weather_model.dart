import 'package:equatable/equatable.dart';

import '../../domain/entities/weather.dart';

class WeatherModel extends Equatable {
  const WeatherModel({
    required this.cityName,
    required this.main,
    required this.description,
    required this.temperature,
  });

  final String cityName;
  final String main;
  final String description;
  final double temperature;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    cityName: json['name'],
    main: json['weather'][0]['main'],
    description: json['weather'][0]['description'],
    temperature: json['main']['temp'],
  );

  Map<String, dynamic> toJson() => {
    'weather': [
      {
        'main': main,
        'description': description,
      },
    ],
    'main': {
      'temp': temperature,
    },
    'name': cityName,
  };

  Weather toEntity() => Weather(
    cityName: cityName,
    main: main,
    description: description,
    temperature: temperature,
  );

  @override
  List<Object?> get props => [
    cityName,
    main,
    description,
    temperature,
  ];
}