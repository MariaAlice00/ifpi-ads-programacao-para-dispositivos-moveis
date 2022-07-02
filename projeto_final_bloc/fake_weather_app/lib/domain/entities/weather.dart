import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  const Weather({
    required this.cityName,
    required this.main,
    required this.description,
    required this.temperature,
  });

  final String cityName;
  final String main;
  final String description;
  final double temperature;

  @override
  List<Object?> get props => [
    cityName,
    main,
    description,
    temperature,
  ];
}