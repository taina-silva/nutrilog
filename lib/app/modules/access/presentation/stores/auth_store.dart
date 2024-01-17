import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/services/local_storage/local_storage_service.dart';
import 'package:nutrilog/app/core/utils/storage_keys.dart';
import 'package:nutrilog/app/modules/access/infra/models/auth_payload_model.dart';
import 'package:nutrilog/app/modules/access/infra/repositories/auth_repository.dart';
import 'package:nutrilog/app/modules/access/presentation/stores/states/auth_states.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final AuthRepository _repository;
  final LocalStorage _localStorage;

  AuthStoreBase(this._repository, this._localStorage);

  @readonly
  SignupState _signupState = SignupInitialState();

  @readonly
  LoginState _loginState = LoginInitialState();

  @observable
  bool passwordIsHidden = true;

  @action
  Future<void> signup(AuthPayloadModel payload) async {
    _signupState = SignupLoadingState();

    final result = await _repository.signup(payload);

    result.fold(
      (l) => _signupState = SignupErrorState(l.message),
      (r) => _signupState = SignupSuccessState(),
    );
  }

  @action
  Future<void> signin(AuthPayloadModel payload) async {
    _loginState = LoginLoadingState();

    final result = await _repository.signin(payload);

    result.fold(
      (l) => _loginState = LoginErrorState(l.message),
      (r) async {
        await _localStorage.write(StorageKeys.userId, r);
        await _localStorage.write(StorageKeys.isLogged, 'true');

        _loginState = LoginSuccessState();
      },
    );
  }

  @action
  Future<void> signout() async {
    _loginState = LoginLoadingState();

    final result = await _repository.signout();

    result.fold(
      (l) => _loginState = LoginErrorState(l.message),
      (r) async {
        await _localStorage.delete(StorageKeys.userId);
        await _localStorage.write(StorageKeys.isLogged, 'false');

        _loginState = LoginSuccessState();
      },
    );
  }
}
