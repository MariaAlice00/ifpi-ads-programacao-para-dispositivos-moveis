// @dart=2.9

import 'dart:convert';

import 'package:advice_slip_api_clean/features/advice/data/datasources/advice_local_datasource.dart';
import 'package:advice_slip_api_clean/features/advice/data/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  AdviceLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  mockSharedPreferences = MockSharedPreferences();
  dataSource = AdviceLocalDataSourceImpl(
    sharedPreferences: mockSharedPreferences,
  );

  group('getLastAdvice', () {
    final tAdviceModel =
        AdviceModel.fromJson(json.decode(fixture('advice_cached.json')));

    test(
      'should return Advice from SharedPreferences when there is one in the cache',
      () async {
        when(mockSharedPreferences.getString(''))
            .thenReturn(fixture('advice_cached.json'));
        final result = await dataSource.getLastAdvice();
        verify(mockSharedPreferences.getString('CACHED_ADVICE'));
        expect(result, equals(tAdviceModel));
      },
    );
  });

  group('cacheAdvice', () {
    final tAdviceModel = AdviceModel(id: 1, advice: 'Be happy');

    test('should call SharedPreferences to cache the data', () {
      dataSource.cacheAdvice(tAdviceModel);
      final expectedJsonString = json.encode(tAdviceModel.toJson());
      verify(mockSharedPreferences.setString(
        CACHED_ADVICE,
        expectedJsonString,
      ));
    });
  });
}