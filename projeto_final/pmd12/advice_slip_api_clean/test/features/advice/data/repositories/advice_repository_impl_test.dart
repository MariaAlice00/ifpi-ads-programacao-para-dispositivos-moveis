import 'package:advice_slip_api_clean/core/platform/network_info.dart';
import 'package:advice_slip_api_clean/features/advice/data/datasources/advice_local_data_source.dart';
import 'package:advice_slip_api_clean/features/advice/data/datasources/advice_remote_data_source.dart';
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
  final mockRemoteDataSource = MockRemoteDataSource();
  final mockLocalDataSource = MockLocalDataSource();
  final mockNetworkInfo = MockNetworkInfo();
  final repository = AdviceRepositoryImpl(
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
    const tId = 1;
    final tAdviceModel =
        AdviceModel(id: tId, advice: 'test trivia');
    final Advice tAdvice = tAdviceModel;

    test(
      'should check if the device is online',
      () async {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        repository.getConcreteAdvice(tId);
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          when(mockRemoteDataSource.GetConcreteAdvice(tId))
              .thenAnswer((_) async => tAdviceModel);

          final result = await repository.getConcreteAdvice(tId);

          verify(mockRemoteDataSource.GetConcreteAdvice(tId));
          expect(result, equals(Right(tAdvice)));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          when(mockLocalDataSource.getLastAdvice())
              .thenAnswer((_) async => tAdviceModel);

          final result = await repository.getConcreteAdvice(tId);

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastAdvice());
          expect(result, equals(Right(tAdvice)));
        },
      );
    });
  });
}