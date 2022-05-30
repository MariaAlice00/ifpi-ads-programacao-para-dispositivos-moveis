// ignore_for_file: prefer_const_constructors

import 'package:api_clean_star_wars/features/starwars/domain/entities/people.dart';
import 'package:api_clean_star_wars/features/starwars/domain/repositories/people_repository.dart';
import 'package:api_clean_star_wars/features/starwars/domain/usecases/get_all_peoples.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPeopleRepository extends Mock implements PeopleRepository {}

void main() {
  GetAllPeoples usecase;
  MockPeopleRepository mockPeopleRepository;

  final peopleExample = People(
    id: 1,
    name: 'Luke Skywalker',
    hair_color: 'blond',
    eye_color: 'blue',
    birth_year: '19BBY',
    gender: "male",
  );

  test('should return peoples', () async {
    mockPeopleRepository = MockPeopleRepository();

    when(mockPeopleRepository.getAllPeoples())
        .thenAnswer((_) async => Right(peopleExample));

    usecase = GetAllPeoples(mockPeopleRepository);

    final result = await usecase.execute();
    expect(result, Right(peopleExample));

    verify(mockPeopleRepository.getAllPeoples());
    verifyNoMoreInteractions(mockPeopleRepository);
  });
}
