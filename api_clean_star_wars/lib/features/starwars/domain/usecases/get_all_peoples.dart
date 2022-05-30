import 'package:api_clean_star_wars/features/starwars/domain/entities/people.dart';
import 'package:api_clean_star_wars/features/starwars/domain/repositories/people_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

class GetAllPeoples {
  final PeopleRepository peopleRepository;

  GetAllPeoples(this.peopleRepository);

  Future<Either<Failure, People>?> execute() async {
    return await peopleRepository.getAllPeoples();
  }
}
