import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_one_meal_model.dart';

class NutritionsByMealOfDayModel extends Equatable {
  final Map<MealType, NutritionsOneMealModel> nutritions;

  const NutritionsByMealOfDayModel({
    required this.nutritions,
  });

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool get stringify => true;

  factory NutritionsByMealOfDayModel.fromMap(Map<String, dynamic> map) {
    Map<MealType, NutritionsOneMealModel> aux = {};

    for (var m in map.entries) {
      if (m.key != 'total-energy') {
        aux.addAll({
          MealType.fromStr(m.key): NutritionsOneMealModel.fromMap(m.value as Map<String, dynamic>),
        });
      }
    }

    return NutritionsByMealOfDayModel(
      nutritions: aux,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> aux = {};

    for (var n in nutritions.entries) {
      aux.addAll({n.key.key: n.value.toMap()});
    }

    return aux;
  }
}
