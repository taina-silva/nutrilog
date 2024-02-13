import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/core/infra/repositories/user_repository.dart';
import 'package:nutrilog/app/core/stores/states/user_states.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  final UserRepository _repository;

  UserStoreBase(this._repository);

  @readonly
  GetUserDayLogState _getUserDayLogState = GetUserDayLogLoadingState();

  @readonly
  RegisterPhysicalActitityState _registerPhysicalActitityState =
      RegisterPhysicalActitityInitialState();

  @readonly
  RegisterNutritionState _registerNutritionState = RegisterNutritionInitialState();

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
    _registerPhysicalActitityState = RegisterPhysicalActitityLoadingState();

    final result = await _repository.registerPhysicalActivity(date, payload);

    result.fold(
      (l) => _registerPhysicalActitityState = RegisterPhysicalActitityErrorState(l.message),
      (r) async {
        await getUserDayLog();
        _registerPhysicalActitityState = RegisterPhysicalActititySuccessState();
      },
    );
  }

  @action
  Future<void> registerNutrition(DateTime date, NutritionWithEnergyModel payload) async {
    _registerNutritionState = RegisterNutritionLoadingState();

    final result = await _repository.registerNutrition(date, payload);

    result.fold(
      (l) => _registerNutritionState = RegisterNutritionErrorState(l.message),
      (r) => _registerNutritionState = RegisterNutritionSuccessState(),
    );
  }
}
