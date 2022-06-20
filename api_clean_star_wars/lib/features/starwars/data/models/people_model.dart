import 'package:api_clean_star_wars/features/starwars/domain/entities/people.dart';

class PeopleModel extends People {
  PeopleModel({
    required id,
    required name,
    required hair_color,
    required eye_color,
    required birth_year,
    required gender,
  }) : super(
          id: id,
          name: name,
          hair_color: hair_color,
          eye_color: eye_color,
          birth_year: birth_year,
          gender: gender,
        );

  factory PeopleModel.fromJson(Map<String, dynamic> json) {
    return PeopleModel(
      id: (json['id'] as num).toInt(),
      name: json['name'],
      hair_color: json['hair_color'],
      eye_color: json['eye_color'],
      birth_year: json['birth_year'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hair_color': hair_color,
      'eye_color': eye_color,
      'birth_year': birth_year,
      'gender': gender,
    };
  }
}
