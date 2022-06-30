// ignore_for_file: prefer_const_constructors_in_immutables


import '../../domain/entities/advice.dart';

class AdviceModel extends Advice {
  AdviceModel({
    required int id,
    required String advice,
  }) : super(
          id: id,
          advice: advice,
        );

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      id: (json['id']as num).toInt(),
      advice: (json['advice']
    ));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'advice': advice,
    };
  }
}