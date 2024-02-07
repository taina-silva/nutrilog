import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/repositories/physical_activities_repository.dart';
import 'package:nutrilog/app/modules/physical_activities/presentation/stores/states/physical_activities_states.dart';

part 'physical_activities_store.g.dart';

class PhysicalActivitiesStore = PhysicalActivitiesStoreBase with _$PhysicalActivitiesStore;

abstract class PhysicalActivitiesStoreBase with Store {
  final PhysicalActivitiesRepository _repository;

  PhysicalActivitiesStoreBase(this._repository);

  @readonly
  GetPhysicalActivitiesState _state = GetPhysicalActivitiesInitialState();

  @action
  Future<void> getAllPhysicalActivities() async {
    _state = GetPhysicalActivitiesLoadingState();

    final result = await _repository.getAllPhysicalActivities();

    result.fold(
      (l) => _state = GetPhysicalActivitiesErrorState(l.message),
      (r) => _state = GetPhysicalActivitiesSuccessState(r),
    );
  }
}
