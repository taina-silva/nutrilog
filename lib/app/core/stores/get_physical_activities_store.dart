import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/infra/repositories/physical_activity/get_physical_activities_repository.dart';
import 'package:nutrilog/app/core/stores/states/get_physical_activity_states.dart';

part 'get_physical_activities_store.g.dart';

class GetPhysicalActivityStore = GetPhysicalActivityStoreBase with _$GetPhysicalActivityStore;

abstract class GetPhysicalActivityStoreBase with Store {
  final GetPhysicalActivityRepository _repository;

  GetPhysicalActivityStoreBase(this._repository);

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
