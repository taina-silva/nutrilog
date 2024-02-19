import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/infra/models/auth/auth_payload_model.dart';
import 'package:nutrilog/app/core/infra/repositories/auth/auth_repository.dart';
import 'package:nutrilog/app/core/services/local_storage/local_storage_service.dart';
import 'package:nutrilog/app/core/stores/states/auth_states.dart';
import 'package:nutrilog/app/core/utils/storage_keys.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final AuthRepository _repository;
  final LocalStorage _localStorage;

  AuthStoreBase(this._repository, this._localStorage);

  @readonly
  SignupState _signupState = SignupInitialState();

  @readonly
  SigninState _signinState = SigninInitialState();

  @readonly
  SignoutState _signoutState = SignoutInitialState();

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
    _signinState = SigninLoadingState();

    final result = await _repository.signin(payload);

    result.fold(
      (l) => _signinState = SigninErrorState(l.message),
      (r) async {
        await _localStorage.write(StorageKeys.userId, r);
        await _localStorage.write(StorageKeys.isLogged, 'true');

        _signinState = SigninSuccessState();
      },
    );
  }

  @action
  Future<void> signout() async {
    _signoutState = SignoutLoadingState();

    final result = await _repository.signout();

    result.fold(
      (l) => _signoutState = SignoutErrorState(l.message),
      (r) async {
        await _localStorage.delete(StorageKeys.userId);
        await _localStorage.write(StorageKeys.isLogged, 'false');

        _signoutState = SignoutSuccessState();
      },
    );
  }
}
