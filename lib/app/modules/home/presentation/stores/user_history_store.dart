import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_by_meal_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/modules/home/infra/repositories/user_history_repository.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/states/user_history_states.dart';

part 'user_history_store.g.dart';

class UserHistoryStore = UserHistoryStoreBase with _$UserHistoryStore;

abstract class UserHistoryStoreBase with Store {
  final UserHistoryRepository repository;

  UserHistoryStoreBase(this.repository);

  @readonly
  GetHistoryState _getHistoryState = GetHistoryInitialState();

  @readonly
  ManagePhysicalActivityState _managePhysicalActivityState = ManagePhysicalActivityInitialState();

  @readonly
  ManageNutritionState _manageNutritionState = ManageNutritionInitialState();

  @action
  Future<void> getHistory() async {
    _getHistoryState = GetHistoryLoadingState();

    final history = await repository.getHistory();
    history.fold(
      (l) => _getHistoryState = GetHistoryErrorState(l.message),
      (r) => _getHistoryState = GetHistorySuccessState(r),
    );
  }

  @action
  Future<void> registerPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel payload) async {
    _managePhysicalActivityState = ManagePhysicalActivityLoadingState();

    final result = await repository.registerPhysicalActivity(date, payload);
    result.fold(
      (l) => _managePhysicalActivityState = ManagePhysicalActivityErrorState(l.message),
      (r) => _managePhysicalActivityState = ManagePhysicalActivitySuccessState(),
    );
  }

  @action
  Future<void> registerNutrition(DateTime date, NutritionsByMealModel payload) async {
    _manageNutritionState = ManageNutritionLoadingState();

    final result = await repository.registerNutrition(date, payload);
    result.fold(
      (l) => _manageNutritionState = ManageNutritionErrorState(l.message),
      (r) => _manageNutritionState = ManageNutritionSuccessState(),
    );
  }

  @action
  Future<void> unregisterPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel payload) async {
    _managePhysicalActivityState = ManagePhysicalActivityLoadingState();

    final result = await repository.unregisterPhysicalActivity(date, payload);
    result.fold(
      (l) => _managePhysicalActivityState = ManagePhysicalActivityErrorState(l.message),
      (r) => _managePhysicalActivityState = ManagePhysicalActivitySuccessState(),
    );
  }

  @action
  Future<void> unregisterNutrition(DateTime date, NutritionsByMealModel payload) async {
    _manageNutritionState = ManageNutritionLoadingState();

    final result = await repository.unregisterNutrition(date, payload);
    result.fold(
      (l) => _manageNutritionState = ManageNutritionErrorState(l.message),
      (r) => _manageNutritionState = ManageNutritionSuccessState(),
    );
  }
}
