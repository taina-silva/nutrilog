import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_one_meal_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/core/infra/repositories/user/user_repository.dart';
import 'package:nutrilog/app/core/stores/states/user_states.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  final UserRepository _repository;

  UserStoreBase(this._repository);

  @readonly
  GetUserDayLogState _getUserDayLogState = GetUserDayLogLoadingState();

  @readonly
  RegisterPhysicalActivityState _registerPhysicalActitityState =
      RegisterPhysicalActivityInitialState();

  @readonly
  RegisterNutritionState _registerNutritionState = RegisterNutritionInitialState();

  @readonly
  UnregisterPhysicalActivityState _unregisterPhysicalActitityState =
      UnregisterPhysicalActivityInitialState();

  @readonly
  UnregisterNutritionState _unregisterNutritionState = UnregisterNutritionInitialState();

  @action
  Future<void> getUserDayLog() async {
    _getUserDayLogState = GetUserDayLogLoadingState();

    final result = await _repository.getDayLogList();

    result.fold(
      (l) => _getUserDayLogState = GetUserDayLogErrorState(l.message),
      (r) => _getUserDayLogState = GetUserDayLogSuccessState(r ?? []),
    );
  }

  @action
  Future<void> registerPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel payload) async {
    _registerPhysicalActitityState = RegisterPhysicalActivityLoadingState();

    final result = await _repository.registerPhysicalActivity(date, payload);

    result.fold(
      (l) => _registerPhysicalActitityState = RegisterPhysicalActivityErrorState(l.message),
      (r) => _registerPhysicalActitityState = RegisterPhysicalActivitySuccessState(),
    );
  }

  @action
  Future<void> registerNutrition(DateTime date, NutritionsOneMealModel payload) async {
    _registerNutritionState = RegisterNutritionLoadingState();

    final result = await _repository.registerNutrition(date, payload);

    result.fold(
      (l) => _registerNutritionState = RegisterNutritionErrorState(l.message),
      (r) => _registerNutritionState = RegisterNutritionSuccessState(),
    );
  }

  @action
  Future<void> unregisterPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel payload) async {
    _unregisterPhysicalActitityState = UnregisterPhysicalActivityLoadingState();

    final result = await _repository.unregisterPhysicalActivity(date, payload);

    result.fold(
      (l) => _unregisterPhysicalActitityState = UnregisterPhysicalActivityErrorState(l.message),
      (r) => _unregisterPhysicalActitityState = UnregisterPhysicalActivitySuccessState(),
    );
  }

  @action
  Future<void> unregisterNutrition(
      DateTime date, MealType mealType, NutritionWithEnergyModel payload) async {
    _unregisterNutritionState = UnregisterNutritionLoadingState();

    final result = await _repository.unregisterNutrition(date, mealType, payload);

    result.fold(
      (l) => _unregisterNutritionState = UnregisterNutritionErrorState(l.message),
      (r) => _unregisterNutritionState = UnregisterNutritionSuccessState(),
    );
  }
}
