// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on UserStoreBase, Store {
  late final _$_getUserDayLogStateAtom =
      Atom(name: 'UserStoreBase._getUserDayLogState', context: context);

  GetUserDayLogState get getUserDayLogState {
    _$_getUserDayLogStateAtom.reportRead();
    return super._getUserDayLogState;
  }

  @override
  GetUserDayLogState get _getUserDayLogState => getUserDayLogState;

  @override
  set _getUserDayLogState(GetUserDayLogState value) {
    _$_getUserDayLogStateAtom.reportWrite(value, super._getUserDayLogState, () {
      super._getUserDayLogState = value;
    });
  }

  late final _$_registerPhysicalActitityStateAtom = Atom(
      name: 'UserStoreBase._registerPhysicalActitityState', context: context);

  RegisterPhysicalActitityState get registerPhysicalActitityState {
    _$_registerPhysicalActitityStateAtom.reportRead();
    return super._registerPhysicalActitityState;
  }

  @override
  RegisterPhysicalActitityState get _registerPhysicalActitityState =>
      registerPhysicalActitityState;

  @override
  set _registerPhysicalActitityState(RegisterPhysicalActitityState value) {
    _$_registerPhysicalActitityStateAtom
        .reportWrite(value, super._registerPhysicalActitityState, () {
      super._registerPhysicalActitityState = value;
    });
  }

  late final _$_registerNutritionStateAtom =
      Atom(name: 'UserStoreBase._registerNutritionState', context: context);

  RegisterNutritionState get registerNutritionState {
    _$_registerNutritionStateAtom.reportRead();
    return super._registerNutritionState;
  }

  @override
  RegisterNutritionState get _registerNutritionState => registerNutritionState;

  @override
  set _registerNutritionState(RegisterNutritionState value) {
    _$_registerNutritionStateAtom
        .reportWrite(value, super._registerNutritionState, () {
      super._registerNutritionState = value;
    });
  }

  late final _$getUserDayLogAsyncAction =
      AsyncAction('UserStoreBase.getUserDayLog', context: context);

  @override
  Future<void> getUserDayLog() {
    return _$getUserDayLogAsyncAction.run(() => super.getUserDayLog());
  }

  late final _$registerPhysicalActivityAsyncAction =
      AsyncAction('UserStoreBase.registerPhysicalActivity', context: context);

  @override
  Future<void> registerPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel payload) {
    return _$registerPhysicalActivityAsyncAction
        .run(() => super.registerPhysicalActivity(date, payload));
  }

  late final _$registerNutritionAsyncAction =
      AsyncAction('UserStoreBase.registerNutrition', context: context);

  @override
  Future<void> registerNutrition(
      DateTime date, NutritionWithEnergyModel payload) {
    return _$registerNutritionAsyncAction
        .run(() => super.registerNutrition(date, payload));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
