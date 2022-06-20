import 'package:api_clean_star_wars/core/usecases/usecase.dart';
import 'package:api_clean_star_wars/features/starwars/domain/entities/people.dart';
import 'package:api_clean_star_wars/features/starwars/domain/repositories/people_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

class GetAllPeoples extends UseCase<People, NoParams>{
  final PeopleRepository peopleRepository;

  GetAllPeoples(this.peopleRepository);

  @override
  Future<Either<Failure, People>?> call(NoParams params) async {
    return await peopleRepository.getAllPeoples();
  }
}
