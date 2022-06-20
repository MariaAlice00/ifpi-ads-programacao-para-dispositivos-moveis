import 'package:api_clean_star_wars/core/usecases/usecase.dart';
import 'package:api_clean_star_wars/features/starwars/domain/entities/people.dart';
import 'package:api_clean_star_wars/features/starwars/domain/repositories/people_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';

class GetPeopleById extends UseCase<People, NoParams> {
  final PeopleRepository peopleRepository;

  GetPeopleById(this.peopleRepository);

  Future<Either<Failure, People>?> call(Params params) async {
    return await peopleRepository.getPeopleById(params.id);
  }

  class Params extends Equatable {
    final int id;

    const Params({required this.id});
  }
}
