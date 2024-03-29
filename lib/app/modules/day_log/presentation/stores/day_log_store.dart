import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_model.dart';

part 'day_log_store.g.dart';

class DayLogStore = DayLogStoreBase with _$DayLogStore;

abstract class DayLogStoreBase with Store {
  @observable
  PhysicalActivityModel? physicalActivity;

  @observable
  double? energy;

  @observable
  MealType? mealType;

  @observable
  TimeOfDay? timeOfDay;

  @observable
  List<NutritionWithEnergyModel>? nutritions;
}
