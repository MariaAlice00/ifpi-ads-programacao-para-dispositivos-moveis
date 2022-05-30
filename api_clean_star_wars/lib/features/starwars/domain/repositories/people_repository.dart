import 'package:api_clean_star_wars/features/starwars/domain/entities/people.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class PeopleRepository {
  Future<Either<Failure, People>>? getAllPeoples();
  Future<Either<Failure, People>>? getPeopleById(int id);
}