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

  late final _$_signinStateAtom =
      Atom(name: 'AuthStoreBase._signinState', context: context);

  SigninState get signinState {
    _$_signinStateAtom.reportRead();
    return super._signinState;
  }

  @override
  SigninState get _signinState => signinState;

  @override
  set _signinState(SigninState value) {
    _$_signinStateAtom.reportWrite(value, super._signinState, () {
      super._signinState = value;
    });
  }

  late final _$_signoutStateAtom =
      Atom(name: 'AuthStoreBase._signoutState', context: context);

  SignoutState get signoutState {
    _$_signoutStateAtom.reportRead();
    return super._signoutState;
  }

  @override
  SignoutState get _signoutState => signoutState;

  @override
  set _signoutState(SignoutState value) {
    _$_signoutStateAtom.reportWrite(value, super._signoutState, () {
      super._signoutState = value;
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
