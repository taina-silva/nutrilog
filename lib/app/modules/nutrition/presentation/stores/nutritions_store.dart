import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/modules/nutrition/infra/repositories/nutritions_repository.dart';
import 'package:nutrilog/app/modules/nutrition/presentation/stores/states/nutritions_states.dart';

part 'nutritions_store.g.dart';

class NutritionsStore = NutritionsStoreBase with _$NutritionsStore;

abstract class NutritionsStoreBase with Store {
  final NutritionsRepository _repository;

  NutritionsStoreBase(this._repository);

  @readonly
  GetNutritionsState _state = GetNutritionsInitialState();

  @action
  Future<void> getAllNutritions() async {
    _state = GetNutritionsLoadingState();

    final result = await _repository.getAllNutritions();

    result.fold(
      (l) => _state = GetNutritionsErrorState(l.message),
      (r) => _state = GetNutritionsSuccessState(r.first, r.second),
    );
  }
}
