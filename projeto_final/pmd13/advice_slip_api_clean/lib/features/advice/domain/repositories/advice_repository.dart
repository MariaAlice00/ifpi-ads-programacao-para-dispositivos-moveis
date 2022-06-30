import 'package:advice_slip_api_clean/features/advice/domain/entities/advice.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class AdviceRepository {
  Future<Either<Failure, Advice>>? getConcreteAdvice(int number);
  Future<Either<Failure, Advice>>? getRandomAdvice();
}