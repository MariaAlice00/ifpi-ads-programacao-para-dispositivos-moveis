import 'package:equatable/equatable.dart';

class People extends Equatable {
  final int id;
  final String name;
  final String hair_color;
  final String eye_color;
  final String birth_year;
  final String gender;

  const People({
    required this.id,
    required this.name,
    required this.hair_color,
    required this.eye_color,
    required this.birth_year,
    required this.gender,
  });

  @override
  List<Object> get props => [id, name, hair_color, eye_color, birth_year, gender];
}
