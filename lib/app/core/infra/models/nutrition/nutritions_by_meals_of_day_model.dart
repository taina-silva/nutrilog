// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_one_meal_model.dart';

class NutritionsByMealOfDayModel extends Equatable {
  final List<NutritionsOneMealModel> nutritions;

  const NutritionsByMealOfDayModel({
    required this.nutritions,
  });

  @override
  List<Object> get props => [nutritions];

  @override
  bool get stringify => true;

  factory NutritionsByMealOfDayModel.fromMap(Map<String, dynamic> map) {
    List<NutritionsOneMealModel> aux = [];

    for (var m in map.entries) {
      if (m.key != 'total-energy') {
        aux.add(NutritionsOneMealModel.fromMap(m.value as Map<String, dynamic>));
      }
    }

    return NutritionsByMealOfDayModel(
      nutritions: aux,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> aux = {};

    for (var n in nutritions) {
      aux.addAll({n.mealType.key: n.toMap()});
    }

    return aux;
  }

  NutritionsByMealOfDayModel copyWith({
    List<NutritionsOneMealModel>? nutritions,
  }) {
    return NutritionsByMealOfDayModel(
      nutritions: nutritions ?? this.nutritions,
    );
  }

  String toJson() => json.encode(toMap());

  factory NutritionsByMealOfDayModel.fromJson(String source) =>
      NutritionsByMealOfDayModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
