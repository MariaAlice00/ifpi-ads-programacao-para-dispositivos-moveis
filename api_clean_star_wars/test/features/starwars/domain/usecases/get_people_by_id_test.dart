// ignore_for_file: prefer_const_declarations, prefer_const_constructors

import 'package:api_clean_star_wars/features/starwars/domain/entities/people.dart';
import 'package:api_clean_star_wars/features/starwars/domain/repositories/people_repository.dart';
import 'package:api_clean_star_wars/features/starwars/domain/usecases/get_people_by_id.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockPeopleRepository extends Mock implements PeopleRepository {}

void main() {
  GetPeopleById usecase;
  MockPeopleRepository mockPeopleRepository;

  final peopleExample = People(
    id: 1,
    name: 'Luke Skywalker',
    hair_color: 'blond',
    eye_color: 'blue',
    birth_year: '19BBY',
    gender: "male",
  );

  final idExample = 1;

  test('should return a single people', () async {
    mockPeopleRepository = MockPeopleRepository();

    when(mockPeopleRepository.getPeopleById(idExample))
        .thenAnswer((_) async => Right(peopleExample));

    usecase = GetPeopleById(mockPeopleRepository);

    final result = await usecase.execute(idExample);
    expect(result, Right(peopleExample));

    verify(mockPeopleRepository.getPeopleById(idExample));
    verifyNoMoreInteractions(mockPeopleRepository);
  });
}
