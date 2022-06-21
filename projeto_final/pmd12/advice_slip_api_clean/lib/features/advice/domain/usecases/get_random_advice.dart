import 'package:advice_slip_api_clean/features/advice/domain/entities/advice.dart';
import 'package:advice_slip_api_clean/features/advice/domain/repositories/advice_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetRandomAdvice extends UseCase<Advice, NoParams> {
  final AdviceRepository repository;

  GetRandomAdvice(this.repository);

  @override
  Future<Either<Failure, Advice>?> call(NoParams params) async {
    return await repository.getRandomAdvice();
  }
}