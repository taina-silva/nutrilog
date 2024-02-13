import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';

class NutritionsByMealsModel extends Equatable {
  final double energy;
  final Map<MealType, List<NutritionWithEnergyModel>> nutritions;

  const NutritionsByMealsModel({
    required this.energy,
    required this.nutritions,
  });

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool get stringify => true;

  factory NutritionsByMealsModel.fromMap(Map<String, dynamic> map) {
    Map<MealType, List<NutritionWithEnergyModel>> aux = {};

    for (var m in map.entries) {
      if (m.key != 'total-energy') {
        aux.addAll({
          MealType.fromStr(m.key):
              (m.value as List).map((n) => NutritionWithEnergyModel.fromMap(n)).toList(),
        });
      }
    }

    return NutritionsByMealsModel(
      energy: map['total-energy'] ?? 0,
      nutritions: aux,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> aux = {};

    for (var n in nutritions.entries) {
      aux.addAll({n.key.key: n.value.map((nutrition) => nutrition.toMap())});
    }

    return {
      'totalEnergy': energy,
      'nutritions': aux,
    };
  }
}
