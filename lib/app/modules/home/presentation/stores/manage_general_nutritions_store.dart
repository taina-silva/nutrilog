import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/list_nutritions_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_model.dart';
import 'package:nutrilog/app/modules/home/infra/repositories/manage_general_nutritions_repository.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/states/manage_states.dart';

part 'manage_general_nutritions_store.g.dart';

class ManageGeneralNutritionsStore = ManageGeneralNutritionsStoreBase
    with _$ManageGeneralNutritionsStore;

abstract class ManageGeneralNutritionsStoreBase with Store {
  final ManageGeneralNutritionsRepository _repository;

  ManageGeneralNutritionsStoreBase(this._repository);

  @observable
  ObservableList<ListNutritionsModel> nutritions = ObservableList<ListNutritionsModel>();

  @observable
  ObservableList<ListNutritionsModel> afterSearch = ObservableList<ListNutritionsModel>();

  @readonly
  ManageGeneralNutritionsState _state = ManageGeneralNutritionsInitialState();

  @action
  Future<void> getGeneralNutritions() async {
    final result = await _repository.getGeneralNutritions();
    result.fold(
      (failure) => throw failure,
      (list) => nutritions = List<ListNutritionsModel>.from(list).asObservable(),
    );
  }

  @action
  Future<void> registerNewNutrition(String type, String name) async {
    final nutrition = NutritionModel(type: type, name: name);
    final result = await _repository.registerNewNutrition(nutrition);

    result.fold(
      (l) => _state = ManageGeneralNutritionsErrorState(l.message),
      (_) => _state = ManageGeneralNutritionsSuccessState(),
    );
  }

  @action
  void onSearch(String value) {
    if (value.isEmpty) {
      afterSearch = List<ListNutritionsModel>.from(nutritions).asObservable();
      return;
    }

    final Map<String, List<String>> map = {};

    for (final list in nutritions) {
      for (final pA in list.list) {
        if (pA.toLowerCase().contains(value.toLowerCase())) {
          map.putIfAbsent(list.type, () => []).add(pA);
        }
      }
    }

    afterSearch = map.entries
        .map((entry) => ListNutritionsModel(type: entry.key, list: entry.value))
        .toList()
        .asObservable();
  }
}
