// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:advice_slip_api_clean/features/advice/data/models/advice_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';

abstract class AdviceLocalDataSource {
  Future<AdviceModel> getLastAdvice();

  Future<void> cacheAdvice(AdviceModel adviceToCache);
}

const CACHED_ADVICE = 'CACHED_ADVICE';

class AdviceLocalDataSourceImpl implements AdviceLocalDataSource {
  final SharedPreferences sharedPreferences;

  AdviceLocalDataSourceImpl({
    required this.sharedPreferences
  });

  @override
  Future<AdviceModel> getLastAdvice() {
    final jsonString = sharedPreferences.getString('CACHED_ADVICE');
    if (jsonString != null) {
      return Future.value(AdviceModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheAdvice(AdviceModel adviceToCache) {
    return sharedPreferences.setString(
    CACHED_ADVICE,
    json.encode(adviceToCache.toJson()),
  );
  }
}