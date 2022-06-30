// @dart=2.9
import '../models/advice_model.dart';

abstract class AdviceLocalDataSource {
  Future<AdviceModel> getLastAdvice();

  Future<void> cacheAdvice(AdviceModel adviceToCache);
}