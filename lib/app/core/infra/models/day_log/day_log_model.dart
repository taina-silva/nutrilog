import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_by_meals_of_day_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';

class DayLogModel extends Equatable {
  final DateTime date;
  final List<PhysicalActivityWithDurationModel> physicalActivities;
  final NutritionsByMealOfDayModel? nutritions;

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
    return DayLogModel(
      date: DateTime.fromMillisecondsSinceEpoch(int.parse(map['date'])),
      physicalActivities: map['physical-activities'] == null
          ? []
          : (map['physical-activities'] as List)
              .map((e) => PhysicalActivityWithDurationModel.fromMap(e))
              .toList(),
      nutritions: map['nutrition'] == null
          ? null
          : NutritionsByMealOfDayModel.fromMap(
              map['nutrition'],
            ),
    );
  }
}
