import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/infra/models/register_physical_activity_payload_model.dart';
import 'package:nutrilog/app/core/infra/repositories/user_repository.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  final UserRepository _repository;

  const UserStoreBase(this._repository);

  @action
  Future<void> registerPhysicalActivity(DateTime date, RegisterPhysicalActivityPayloadModel payload) async {
    final result = await _repository.registerPhysicalActivity(date, payload);

    result.fold((l) => null, (r) => null);
  }
}