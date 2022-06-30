
import 'package:advice_slip_api_clean/features/advice/data/datasources/advice_local_datasource.dart';
import 'package:advice_slip_api_clean/features/advice/data/datasources/advice_remote_datasource.dart';
import 'package:advice_slip_api_clean/features/advice/domain/entities/advice.dart';
import 'package:advice_slip_api_clean/features/advice/domain/repositories/advice_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';

class AdviceRepositoryImpl implements AdviceRepository {
  final AdviceRemoteDataSource remoteDataSource;
  final AdviceLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AdviceRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Advice>>? getConcreteAdvice(int number) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await remoteDataSource.getRandomAdvice();
        localDataSource.cacheAdvice(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastAdvice();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Advice>>? getRandomAdvice() {
    return null;
  }
}