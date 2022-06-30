import 'dart:convert';

import 'package:advice_slip_api_clean/core/error/exception.dart';
import 'package:advice_slip_api_clean/features/advice/data/datasources/advice_remote_datasource.dart';
import 'package:advice_slip_api_clean/features/advice/data/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  AdviceRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  mockHttpClient = MockHttpClient();
  dataSource = AdviceRemoteDataSourceImpl(client: mockHttpClient);

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(Uri.parse('https://api.adviceslip.com/advice/1'), headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('advice.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(Uri.parse('https://api.adviceslip.com/advice/1'), headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('getConcreteAdvice', () {
    const tNumber = 1;
    final tAdviceModel =
    AdviceModel.fromJson(json.decode(fixture('advice.json')));

    test(
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
      () {
        //arrange
        when(mockHttpClient.get(Uri.parse('https://api.adviceslip.com/advice/$tNumber'), headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('advice.json'), 200),
        );
        dataSource.getConcreteAdvice(tNumber);
        verify(mockHttpClient.get(
          Uri.parse('https://api.adviceslip.com/advice/$tNumber'),
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return Advice when the response code is 200 (success)',
      () async {
        when(mockHttpClient.get(Uri.parse('https://api.adviceslip.com/advice/$tNumber'), headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('advice.json'), 200),
        );
        final result = await dataSource.getConcreteAdvice(tNumber);
        expect(result, equals(tAdviceModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('https://api.adviceslip.com/advice/$tNumber'), headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response('Something went wrong', 404),
        );
        final call = dataSource.getConcreteAdvice;
        expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('getRandomAdvice', () {
    final tAdviceModel =
        AdviceModel.fromJson(json.decode(fixture('advice.json')));

    test(
      'should preform a GET request on a URL with *random* endpoint with application/json header',
      () {
        //arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getRandomAdvice();
        // assert
        verify(mockHttpClient.get(
          Uri.parse('https://api.adviceslip.com/advice/1'),
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return Advice when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getRandomAdvice();
        // assert
        expect(result, equals(tAdviceModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getRandomAdvice;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
