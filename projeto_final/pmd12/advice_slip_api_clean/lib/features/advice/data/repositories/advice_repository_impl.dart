import 'package:advice_slip_api_clean/features/advice/domain/entities/advice.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/repositories/advice_repository.dart';
import '../datasources/advice_local_data_source.dart';
import '../datasources/advice_remote_data_source.dart';

typedef Future<Advice> _ConcreteOrRandomChooser();

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
  Future<Either<Failure, Advice>> getConcreteAdvice(
    int number,
  ) async {
    if (await networkInfo.isConnected!) {
      //get remote data
      try {
        final remoteAdvice =
        await remoteDataSource.GetConcreteAdvice(number);
        localDataSource.cacheAdvice(remoteAdvice);
        return Right(remoteAdvice);
        } on ServerException {
          return Left(ServerFailure());
        }
    } else {
    //get local data
    try {
      final localAdvice = await localDataSource.getLastAdvice();
      return Right(localAdvice);
      } on CacheException {
      return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Advice>>? getRandomAdvice() {
    // TODO: implement getRandomAdvice
    throw UnimplementedError();
  }

  // @override
  // Future<Either<Failure, Advice>> getRandomAdvice() async {
  //   if (await networkInfo.isConnected) {
  //     //get remote data
  //     try {
  //       final remoteAdvice = await remoteDataSource.GetRandomAdvice();
  //       localDataSource.cacheAdvice(remoteAdvice);
  //       return Right(remoteAdvice);
  //       } on ServerException {
  //       return Left(ServerFailure());
  //       }
  //   } else {
  //   //get local data
  //     final localAdvice = await localDataSource.getLastAdvice();
  //     return Right(localAdvice);
  //     } on CacheException {
  //     return Left(CacheFailure());
  //   }
  // }
}