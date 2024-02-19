import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';
import 'package:nutrilog/app/core/utils/time_of_day.dart';

class NutritionsOneMealModel extends Equatable {
  final double energy;
  final MealType mealType;
  final TimeOfDay timeOfDay;
  final List<NutritionWithEnergyModel> nutritions;

  const NutritionsOneMealModel({
    required this.energy,
    required this.mealType,
    required this.timeOfDay,
    required this.nutritions,
  });

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool get stringify => true;

  factory NutritionsOneMealModel.fromMap(Map<String, dynamic> map) {
    return NutritionsOneMealModel(
      energy: map['total-energy'],
      mealType: MealType.fromStr(map['meal-type']),
      timeOfDay: timeOfDayFromStr(map['time']),
      nutritions:
          (map['nutritions'] as List).map((n) => NutritionWithEnergyModel.fromMap(n)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    double totalEnergy = energy;

    if (totalEnergy == 0) {
      for (NutritionWithEnergyModel n in nutritions) {
        totalEnergy += n.energy ?? 0;
      }
    }

    return {
      'total-energy': totalEnergy,
      'meal-type': mealType.key,
      'time': timeOfDayAsStr(timeOfDay),
      'nutritions': nutritions.map((n) => n.toMap()),
    };
  }

  NutritionsOneMealModel copyWith({
    double? energy,
    MealType? mealType,
    TimeOfDay? timeOfDay,
    List<NutritionWithEnergyModel>? nutritions,
  }) {
    return NutritionsOneMealModel(
      energy: energy ?? this.energy,
      mealType: mealType ?? this.mealType,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      nutritions: nutritions ?? this.nutritions,
    );
  }
}
