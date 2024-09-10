import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_by_meal_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/user_history_store.dart';

part 'new_log_store.g.dart';

class NewLogStore = NewLogStoreBase with _$NewLogStore;

abstract class NewLogStoreBase with Store {
  final UserHistoryStore _userHistoryStore;

  NewLogStoreBase(this._userHistoryStore);

  @observable
  PhysicalActivityModel? physicalActivity;

  @observable
  double? energy;

  @observable
  MealType? mealType;

  @observable
  TimeOfDay? time;

  @observable
  List<NutritionWithEnergyModel>? nutritions;

  Future<void> registerPhysicalActivity(DateTime date, Duration duration) async {
    if (physicalActivity == null) return;

    await _userHistoryStore.registerPhysicalActivity(
      date,
      PhysicalActivityWithDurationModel(physicalActivity: physicalActivity!, duration: duration),
    );
  }

  Future<void> registerNutrition(DateTime date) async {
    if (nutritions == null || mealType == null || time == null) return;

    await _userHistoryStore.registerNutrition(
      date,
      NutritionsByMealModel(
        time: time!,
        meal: mealType!,
        nutritions: nutritions!,
        energy: energy ?? 0,
      ),
    );
  }
}
