import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/list_physical_activities_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_model.dart';
import 'package:nutrilog/app/modules/home/infra/repositories/manage_general_physical_activities_repository.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/states/manage_states.dart';

part 'manage_general_physical_activities_store.g.dart';

class ManageGeneralPhysicalActivitiesStore = ManageGeneralPhysicalActivitiesStoreBase
    with _$ManageGeneralPhysicalActivitiesStore;

abstract class ManageGeneralPhysicalActivitiesStoreBase with Store {
  final ManageGeneralPhysicalActivitiesRepository _repository;

  ManageGeneralPhysicalActivitiesStoreBase(this._repository);

  @observable
  ObservableList<ListPhysicalActivitiesModel> physicalActivities =
      ObservableList<ListPhysicalActivitiesModel>();

  @observable
  ObservableList<ListPhysicalActivitiesModel> afterSearch =
      ObservableList<ListPhysicalActivitiesModel>();

  @readonly
  ManageGeneralPhysicalActivitiesState _state = ManageGeneralPhysicalActivitiesInitialState();

  @action
  Future<void> getGeneralPhysicalActivities() async {
    final result = await _repository.getGeneralPhysicalActivities();
    result.fold(
      (failure) => throw failure,
      (list) => physicalActivities = List<ListPhysicalActivitiesModel>.from(list).asObservable(),
    );
  }

  @action
  Future<void> registerNewPhysicalActivity(String type, String name) async {
    final physicalActivity = PhysicalActivityModel(type: type, name: name);
    final result = await _repository.registerNewPhysicalActivity(physicalActivity);

    result.fold(
      (l) => _state = ManageGeneralPhysicalActivitiesErrorState(l.message),
      (_) => _state = ManageGeneralPhysicalActivitiesSuccessState(),
    );
  }

  @action
  void onSearch(String value) {
    if (value.isEmpty) {
      afterSearch = physicalActivities;
      return;
    }

    final Map<String, List<String>> map = {};

    for (final list in physicalActivities) {
      for (final pA in list.list) {
        if (pA.toLowerCase().contains(value.toLowerCase())) {
          map.putIfAbsent(list.type, () => []).add(pA);
        }
      }
    }

    afterSearch = map.entries
        .map((entry) => ListPhysicalActivitiesModel(type: entry.key, list: entry.value))
        .toList()
        .asObservable();
  }
}
