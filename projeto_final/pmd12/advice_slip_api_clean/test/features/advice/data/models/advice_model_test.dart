import 'dart:convert';
import 'package:advice_slip_api_clean/features/advice/data/models/advice_model.dart';
import 'package:advice_slip_api_clean/features/advice/domain/entities/advice.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';


void main() {
  final tAdviceModel = AdviceModel(id: 1, advice: 'Be happy!!!');

  test(
    'should be a subclass of Advice entity',
    () async {
      // assert
      expect(tAdviceModel, isA<Advice>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia.json'));
        final result = AdviceModel.fromJson(jsonMap);
        expect(result, tAdviceModel);
      },
    );

    test(
      'should return a JSON map containing the proper data',
      () async {
        final result = tAdviceModel.toJson();
        final expectedJsonMap = {
          "id": 1,
          "advice": "Be happy!!!",
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}