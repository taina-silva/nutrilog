import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';
import 'package:nutrilog/app/core/utils/time_of_day.dart';

class NutritionsByMealModel extends Equatable {
  final TimeOfDay? time;
  final MealType meal;
  final double energy;
  final List<NutritionWithEnergyModel> nutritions;

  const NutritionsByMealModel({
    required this.meal,
    required this.nutritions,
    this.time,
    this.energy = 0,
  });

  @override
  List<Object> get props => [meal, nutritions, energy];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return {
      if (time != null) 'time': timeOfDayAsStr(time!),
      'meal': meal.toString(),
      'energy': energy,
      'nutritions': nutritions.map((item) => item.toMap()).toList(),
    };
  }

  factory NutritionsByMealModel.fromMap(Map<String, dynamic> map) {
    return NutritionsByMealModel(
      time: timeOfDayFromStr(map['time']),
      meal: MealType.fromStr(map['meal']),
      energy: map['energy'],
      nutritions: (map['nutritions'] as List)
          .map((item) => NutritionWithEnergyModel.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  NutritionsByMealModel copyWith({
    TimeOfDay? time,
    MealType? meal,
    double? energy,
    List<NutritionWithEnergyModel>? nutritions,
  }) {
    return NutritionsByMealModel(
      time: time ?? this.time,
      meal: meal ?? this.meal,
      energy: energy ?? this.energy,
      nutritions: nutritions ?? this.nutritions,
    );
  }
}
