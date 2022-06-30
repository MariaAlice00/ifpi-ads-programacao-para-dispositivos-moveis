import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:advice_slip_api_clean/features/advice/data/models/advice_model.dart';

import '../../../../core/error/exception.dart';

abstract class AdviceRemoteDataSource {
  Future<AdviceModel> getConcreteAdvice(int number);

  Future<AdviceModel> getRandomAdvice();
}

class AdviceRemoteDataSourceImpl implements AdviceRemoteDataSource {
  final http.Client client;

  AdviceRemoteDataSourceImpl({required this.client});

  @override
  Future<AdviceModel> getConcreteAdvice(int number) =>
      _getAdviceFromUrl('https://api.adviceslip.com/advice/$number');

  @override
  Future<AdviceModel> getRandomAdvice() =>
      _getAdviceFromUrl('https://api.adviceslip.com/advice');

  Future<AdviceModel> _getAdviceFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return AdviceModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}