// @dart=2.9
import 'package:advice_slip_api_clean/core/error/exception.dart';
import 'package:advice_slip_api_clean/core/error/failures.dart';
import 'package:advice_slip_api_clean/core/platform/network_info.dart';
import 'package:advice_slip_api_clean/features/advice/data/datasources/advice_local_datasource.dart';
import 'package:advice_slip_api_clean/features/advice/data/datasources/advice_remote_datasource.dart';
import 'package:advice_slip_api_clean/features/advice/data/models/advice_model.dart';
import 'package:advice_slip_api_clean/features/advice/data/repositories/advice_repository_impl.dart';
import 'package:advice_slip_api_clean/features/advice/domain/entities/advice.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock
    implements AdviceRemoteDataSource {}

class MockLocalDataSource extends Mock implements AdviceLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  AdviceRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;


  mockRemoteDataSource = MockRemoteDataSource();
  mockLocalDataSource = MockLocalDataSource();
  mockNetworkInfo = MockNetworkInfo();
  repository = AdviceRepositoryImpl(
    remoteDataSource: mockRemoteDataSource,
    localDataSource: mockLocalDataSource,
    networkInfo: mockNetworkInfo,
  );

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getConcreteAdvice', () {
    const tNumber = 1;
    final tAdviceModel =
        AdviceModel(id: 1, advice: 'test advice');
    final Advice tAdvice = tAdviceModel;

    test('should check if the device is online', () {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getConcreteAdvice(tNumber);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getConcreteAdvice(tNumber))
              .thenAnswer((_) async => tAdviceModel);
          // act
          final result = await repository.getConcreteAdvice(tNumber);
          // assert
          verify(mockRemoteDataSource.getConcreteAdvice(tNumber));
          expect(result, equals(Right(tAdvice)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getConcreteAdvice(tNumber))
              .thenAnswer((_) async => tAdviceModel);
          // act
          await repository.getConcreteAdvice(tNumber);
          // assert
          verify(mockRemoteDataSource.getConcreteAdvice(tNumber));
          verify(mockLocalDataSource.cacheAdvice(tAdviceModel));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getConcreteAdvice(tNumber))
              .thenThrow(ServerException());
          // act
          final result = await repository.getConcreteAdvice(tNumber);
          // assert
          verify(mockRemoteDataSource.getConcreteAdvice(tNumber));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastAdvice())
              .thenAnswer((_) async => tAdviceModel);
          // act
          final result = await repository.getConcreteAdvice(tNumber);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastAdvice());
          expect(result, equals(Right(tAdvice)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastAdvice)
              .thenThrow(CacheException());
          // act
          final result = await repository.getConcreteAdvice(tNumber);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastAdvice());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

  group('getRandomAdvice', () {
    final tAdviceModel =
        AdviceModel(id: 1, advice: 'test advice');
    final Advice tAdvice = tAdviceModel;

    test('should check if the device is online', () {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getRandomAdvice();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomAdvice())
              .thenAnswer((_) async => tAdviceModel);
          // act
          final result = await repository.getRandomAdvice();
          // assert
          verify(mockRemoteDataSource.getRandomAdvice());
          expect(result, equals(Right(tAdvice)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomAdvice())
              .thenAnswer((_) async => tAdviceModel);
          // act
          await repository.getRandomAdvice();
          // assert
          verify(mockRemoteDataSource.getRandomAdvice());
          verify(mockLocalDataSource.cacheAdvice(tAdvice));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getRandomAdvice())
              .thenThrow(ServerException());
          // act
          final result = await repository.getRandomAdvice();
          // assert
          verify(mockRemoteDataSource.getRandomAdvice());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastAdvice())
              .thenAnswer((_) async => tAdviceModel);
          // act
          final result = await repository.getRandomAdvice();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastAdvice());
          expect(result, equals(Right(tAdvice)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getLastAdvice())
              .thenThrow(CacheException());
          // act
          final result = await repository.getRandomAdvice();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastAdvice());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

}