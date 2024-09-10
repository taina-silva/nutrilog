import 'package:fpdart/fpdart.dart';
import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_by_meal_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/states/user_history_states.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/user_history_store.dart';

part 'daily_history_store.g.dart';

class DailyHistoryStore = DailyHistoryStoreBase with _$DailyHistoryStore;

abstract class DailyHistoryStoreBase with Store {
  final UserHistoryStore _userHistoryStore;

  DailyHistoryStoreBase(this._userHistoryStore);

  @observable
  DateTime? selectedDate;

  @observable
  ObservableList<PhysicalActivityWithDurationModel> physicalActivities =
      ObservableList<PhysicalActivityWithDurationModel>();

  @observable
  ObservableList<NutritionsByMealModel> nutritions = ObservableList<NutritionsByMealModel>();

  @observable
  PhysicalActivityWithDurationModel? physicalActivityBeingDeleted;

  @observable
  Tuple2<MealType, NutritionWithEnergyModel>? nutritionBeingDeleted;

  @action
  void getPhysicalActivities(DateTime date) {
    if (_userHistoryStore.getHistoryState is! GetHistorySuccessState) return;

    selectedDate = date;
    physicalActivities.clear();
    physicalActivities.addAll((_userHistoryStore.getHistoryState as GetHistorySuccessState)
        .list
        .where((element) => element.date.isAtSameMomentAs(date))
        .map((e) => e.physicalActivities)
        .expand((element) => element)
        .toList());
  }

  @action
  void getNutritions(DateTime date) {
    if (_userHistoryStore.getHistoryState is! GetHistorySuccessState) return;

    selectedDate = date;
    nutritions.clear();
    nutritions.addAll((_userHistoryStore.getHistoryState as GetHistorySuccessState)
        .list
        .where((element) => element.date.isAtSameMomentAs(date))
        .map((e) => e.nutritions)
        .expand((element) => element)
        .toList());
  }

  @action
  void updatePhysicalActivitiesAfterDelete() {
    physicalActivities = ObservableList.of(
      physicalActivities.where((element) => element != physicalActivityBeingDeleted),
    );
  }

  @action
  void updateNutritionsAfterDelete() {
    final mealToDelete = nutritionBeingDeleted?.first;
    final nutritionToDelete = nutritionBeingDeleted?.second;

    nutritions = ObservableList.of(
      nutritions.map((item) {
        if (item.meal == mealToDelete) {
          return item.copyWith(
            nutritions: item.nutritions.where((element) => element != nutritionToDelete).toList(),
          );
        }
        return item;
      }).toList(),
    );
  }
}
