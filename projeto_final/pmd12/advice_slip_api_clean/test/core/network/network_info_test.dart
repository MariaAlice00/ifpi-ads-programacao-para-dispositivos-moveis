// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:advice_slip_api_clean/core/platform/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  mockDataConnectionChecker = MockDataConnectionChecker();
  networkInfo = NetworkInfoImpl(mockDataConnectionChecker);

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);

        when(mockDataConnectionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);

        final result = networkInfo.isConnected;

        verify(mockDataConnectionChecker.hasConnection);

        expect(result, tHasConnectionFuture);
      },
    );
  });
}