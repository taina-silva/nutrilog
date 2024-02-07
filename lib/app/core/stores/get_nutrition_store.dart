import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/infra/repositories/nutrition/get_nutritions_repository.dart';
import 'package:nutrilog/app/core/stores/states/get_nutrition_states.dart';

part 'get_nutrition_store.g.dart';

class GetNutritionStore = GetNutritionStoreBase with _$GetNutritionStore;

abstract class GetNutritionStoreBase with Store {
  final GetNutritionRepository _repository;

  GetNutritionStoreBase(this._repository);

  @readonly
  GetNutritionState _state = GetNutritionInitialState();

  @action
  Future<void> getAllNutritions() async {
    _state = GetNutritionLoadingState();

    final result = await _repository.getAllNutritions();

    result.fold(
      (l) => _state = GetNutritionErrorState(l.message),
      (r) => _state = GetNutritionSuccessState(r),
    );
  }
}
