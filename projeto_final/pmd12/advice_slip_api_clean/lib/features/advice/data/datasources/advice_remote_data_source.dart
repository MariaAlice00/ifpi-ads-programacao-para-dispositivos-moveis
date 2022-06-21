import 'package:advice_slip_api_clean/features/advice/data/models/advice_model.dart';
import 'package:advice_slip_api_clean/features/advice/domain/usecases/get_concrete_advice.dart.dart';
import 'package:advice_slip_api_clean/features/advice/domain/usecases/get_random_advice.dart';

abstract class AdviceRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<AdviceModel> GetConcreteAdvice(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<AdviceModel> GetRandomAdvice();
}