import 'dart:convert';

import 'package:api_clean_star_wars/features/starwars/data/models/people_model.dart';
import 'package:api_clean_star_wars/features/starwars/domain/entities/people.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final peopleExample = PeopleModel(
    id: 1,
    name: 'Luke Skywalker',
    hair_color: 'blond',
    eye_color: 'blue',
    birth_year: '19BBY',
    gender: "male",
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia.json'));
        // act
        final result = PeopleModel.fromJson(jsonMap);
        // assert
        expect(result, peopleExample);
      },
    );
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = peopleExample.toJson();
        // assert
        final expectedJsonMap = {
          "id": 1,
          "name": 'Luke Skywalker',
          "hair_color": 'blond',
          "eye_color": 'blue',
          "birth_year": '19BBY',
          "gender": "male",
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}