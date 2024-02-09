import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/list_nutritions_model.dart';
import 'package:nutrilog/app/core/infra/repositories/nutrition/get_nutritions_repository.dart';
import 'package:nutrilog/app/core/stores/states/get_nutrition_states.dart';

part 'get_nutrition_store.g.dart';

class GetNutritionStore = GetNutritionStoreBase with _$GetNutritionStore;

abstract class GetNutritionStoreBase with Store {
  final GetNutritionRepository _repository;

  GetNutritionStoreBase(this._repository);

  @readonly
  GetNutritionState _state = GetNutritionInitialState();

  @readonly
  List<ListNutritionsModel> _afterSearch = [];

  @action
  Future<void> getAllNutritions() async {
    _state = GetNutritionLoadingState();

    final result = await _repository.getAllNutritions();

    result.fold(
      (l) => _state = GetNutritionErrorState(l.message),
      (r) => _state = GetNutritionSuccessState(r),
    );
  }

  @action
  void onSearch(String value) {
    if (_state is! GetNutritionSuccessState) return;

    if (value.isEmpty) {
      _afterSearch = (_state as GetNutritionSuccessState).nutritions;
      return;
    }

    Map<String, List<String>> map = {};

    for (ListNutritionsModel list in (_state as GetNutritionSuccessState).nutritions) {
      for (String pA in list.list) {
        if (pA.toLowerCase().contains(value.toLowerCase())) {
          if (map[list.type] == null) map[list.type] = [];

          List<String> aux = List.from(map[list.type] ?? []);
          aux.add(pA);
          map[list.type] = aux;
        }
      }
    }

    List<ListNutritionsModel> aux = [];
    for (MapEntry<String, List<String>> item in map.entries) {
      aux.add(ListNutritionsModel(type: item.key, list: item.value));
    }

    _afterSearch = aux;
  }
}
