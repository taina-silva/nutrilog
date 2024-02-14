import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';

class NutritionsForMealModel extends Equatable {
  final double energy;
  final MealType mealType;
  final List<NutritionWithEnergyModel> nutritions;

  const NutritionsForMealModel({
    required this.energy,
    required this.mealType,
    required this.nutritions,
  });

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool get stringify => true;
}
