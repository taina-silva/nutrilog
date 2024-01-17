// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  late final _$_signupStateAtom =
      Atom(name: 'AuthStoreBase._signupState', context: context);

  SignupState get signupState {
    _$_signupStateAtom.reportRead();
    return super._signupState;
  }

  @override
  SignupState get _signupState => signupState;

  @override
  set _signupState(SignupState value) {
    _$_signupStateAtom.reportWrite(value, super._signupState, () {
      super._signupState = value;
    });
  }

  late final _$_loginStateAtom =
      Atom(name: 'AuthStoreBase._loginState', context: context);

  LoginState get loginState {
    _$_loginStateAtom.reportRead();
    return super._loginState;
  }

  @override
  LoginState get _loginState => loginState;

  @override
  set _loginState(LoginState value) {
    _$_loginStateAtom.reportWrite(value, super._loginState, () {
      super._loginState = value;
    });
  }

  late final _$passwordIsHiddenAtom =
      Atom(name: 'AuthStoreBase.passwordIsHidden', context: context);

  @override
  bool get passwordIsHidden {
    _$passwordIsHiddenAtom.reportRead();
    return super.passwordIsHidden;
  }

  @override
  set passwordIsHidden(bool value) {
    _$passwordIsHiddenAtom.reportWrite(value, super.passwordIsHidden, () {
      super.passwordIsHidden = value;
    });
  }

  late final _$signupAsyncAction =
      AsyncAction('AuthStoreBase.signup', context: context);

  @override
  Future<void> signup(AuthPayloadModel payload) {
    return _$signupAsyncAction.run(() => super.signup(payload));
  }

  late final _$signinAsyncAction =
      AsyncAction('AuthStoreBase.signin', context: context);

  @override
  Future<void> signin(AuthPayloadModel payload) {
    return _$signinAsyncAction.run(() => super.signin(payload));
  }

  late final _$signoutAsyncAction =
      AsyncAction('AuthStoreBase.signout', context: context);

  @override
  Future<void> signout() {
    return _$signoutAsyncAction.run(() => super.signout());
  }

  @override
  String toString() {
    return '''
passwordIsHidden: ${passwordIsHidden}
    ''';
  }
}
