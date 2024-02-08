import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/list_physical_activities_model.dart';
import 'package:nutrilog/app/core/infra/repositories/physical_activity/get_physical_activities_repository.dart';
import 'package:nutrilog/app/core/stores/states/get_physical_activity_states.dart';

part 'get_physical_activities_store.g.dart';

class GetPhysicalActivityStore = GetPhysicalActivityStoreBase with _$GetPhysicalActivityStore;

abstract class GetPhysicalActivityStoreBase with Store {
  final GetPhysicalActivityRepository _repository;

  GetPhysicalActivityStoreBase(this._repository);

  @readonly
  GetPhysicalActivitiesState _state = GetPhysicalActivitiesInitialState();

  @readonly
  List<ListPhysicalActivitiesModel> _afterSearch = [];

  @action
  Future<void> getAllPhysicalActivities() async {
    _state = GetPhysicalActivitiesLoadingState();

    final result = await _repository.getAllPhysicalActivities();

    result.fold(
      (l) => _state = GetPhysicalActivitiesErrorState(l.message),
      (r) => _state = GetPhysicalActivitiesSuccessState(r),
    );
  }

  @action
  void onSearch(String value) {
    if (_state is! GetPhysicalActivitiesSuccessState) return;

    if (value.isEmpty) {
      _afterSearch = (_state as GetPhysicalActivitiesSuccessState).physicalActivities;
      return;
    }

    Map<String, List<String>> map = {};

    for (ListPhysicalActivitiesModel list
        in (_state as GetPhysicalActivitiesSuccessState).physicalActivities) {
      for (String pA in list.list) {
        if (pA.toLowerCase().contains(value.toLowerCase())) {
          if (map[list.type] == null) map[list.type] = [];

          List<String> aux = List.from(map[list.type] ?? []);
          aux.add(pA);
          map[list.type] = aux;
        }
      }
    }

    List<ListPhysicalActivitiesModel> aux = [];
    for (MapEntry<String, List<String>> item in map.entries) {
      aux.add(ListPhysicalActivitiesModel(type: item.key, list: item.value));
    }

    _afterSearch = aux;
  }
}
