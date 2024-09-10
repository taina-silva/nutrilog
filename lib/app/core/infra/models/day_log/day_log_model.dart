import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_by_meal_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';

class DayLogModel extends Equatable {
  final DateTime date;
  final List<PhysicalActivityWithDurationModel> physicalActivities;
  final List<NutritionsByMealModel> nutritions;

  const DayLogModel({
    required this.date,
    required this.physicalActivities,
    required this.nutritions,
  });

  @override
  List<Object> get props => [date, physicalActivities];

  @override
  bool get stringify => true;

  factory DayLogModel.fromMap(Map<String, dynamic> map) {
    List<Map<String, dynamic>> nutritions = map.entries
        .where((e) => MealType.values.any((mealType) => mealType.key == e.key))
        .map((e) => {...Map<String, dynamic>.from(e.value), 'meal': e.key})
        .toList();

    return DayLogModel(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      physicalActivities: (map['physical-activities'] as List?)
              ?.map((e) => PhysicalActivityWithDurationModel.fromMap(e))
              .toList() ??
          [],
      nutritions: nutritions.map((e) => NutritionsByMealModel.fromMap(e)).toList(),
    );
  }
}
