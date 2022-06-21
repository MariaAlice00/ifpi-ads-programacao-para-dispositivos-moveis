import 'package:advice_slip_api_clean/features/advice/domain/entities/advice.dart';
import 'package:advice_slip_api_clean/features/advice/domain/repositories/advice_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetConcreteAdvice extends UseCase<Advice, Params> {
  final AdviceRepository repository;

  GetConcreteAdvice(this.repository);

  @override
  Future<Either<Failure, Advice>?> call(Params params) async {
    return await repository.getConcreteAdvice(params.number);
  }
}

class Params extends Equatable {
  final int number;
  
  const Params({
    required this.number,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
