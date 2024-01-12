import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/modules/access/infra/models/auth_payload_model.dart';
import 'package:nutrilog/app/modules/access/infra/repositories/auth_repository.dart';
import 'package:nutrilog/app/modules/access/presentation/stores/states/auth_states.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final AuthRepository _repository;

  AuthStoreBase(this._repository);

  @readonly
  SignupState _signupState = SignupInitialState();

  @readonly
  LoginState _loginState = LoginInitialState();

  @observable
  AuthPayloadModel? payload;

  @action
  Future<void> signup() async {
    if (payload == null || payload?.email == null || payload?.password == null) return;

    final result = await _repository.signup(payload!);

    result.fold(
      (l) => _signupState = SignupErrorState(l.message),
      (r) => _signupState = SignupSuccessState(),
    );
  }

  @action
  Future<void> login() async {
    if (payload == null || payload?.email == null || payload?.password == null) return;

    final result = await _repository.login(payload!);

    result.fold(
      (l) => _loginState = LoginErrorState(l.message),
      (r) => _loginState = LoginSuccessState(),
    );
  }
}
