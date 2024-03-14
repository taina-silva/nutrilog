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

  RegisterPhysicalActivityState get registerPhysicalActitityState {
    _$_registerPhysicalActitityStateAtom.reportRead();
    return super._registerPhysicalActitityState;
  }

  @override
  RegisterPhysicalActivityState get _registerPhysicalActitityState =>
      registerPhysicalActitityState;

  @override
  set _registerPhysicalActitityState(RegisterPhysicalActivityState value) {
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

  late final _$_unregisterPhysicalActitityStateAtom = Atom(
      name: 'UserStoreBase._unregisterPhysicalActitityState', context: context);

  UnregisterPhysicalActivityState get unregisterPhysicalActitityState {
    _$_unregisterPhysicalActitityStateAtom.reportRead();
    return super._unregisterPhysicalActitityState;
  }

  @override
  UnregisterPhysicalActivityState get _unregisterPhysicalActitityState =>
      unregisterPhysicalActitityState;

  @override
  set _unregisterPhysicalActitityState(UnregisterPhysicalActivityState value) {
    _$_unregisterPhysicalActitityStateAtom
        .reportWrite(value, super._unregisterPhysicalActitityState, () {
      super._unregisterPhysicalActitityState = value;
    });
  }

  late final _$_unregisterNutritionStateAtom =
      Atom(name: 'UserStoreBase._unregisterNutritionState', context: context);

  UnregisterNutritionState get unregisterNutritionState {
    _$_unregisterNutritionStateAtom.reportRead();
    return super._unregisterNutritionState;
  }

  @override
  UnregisterNutritionState get _unregisterNutritionState =>
      unregisterNutritionState;

  @override
  set _unregisterNutritionState(UnregisterNutritionState value) {
    _$_unregisterNutritionStateAtom
        .reportWrite(value, super._unregisterNutritionState, () {
      super._unregisterNutritionState = value;
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
      DateTime date, NutritionsOneMealModel payload) {
    return _$registerNutritionAsyncAction
        .run(() => super.registerNutrition(date, payload));
  }

  late final _$unregisterPhysicalActivityAsyncAction =
      AsyncAction('UserStoreBase.unregisterPhysicalActivity', context: context);

  @override
  Future<void> unregisterPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel payload) {
    return _$unregisterPhysicalActivityAsyncAction
        .run(() => super.unregisterPhysicalActivity(date, payload));
  }

  late final _$unregisterNutritionAsyncAction =
      AsyncAction('UserStoreBase.unregisterNutrition', context: context);

  @override
  Future<void> unregisterNutrition(
      DateTime date, MealType mealType, NutritionWithEnergyModel payload) {
    return _$unregisterNutritionAsyncAction
        .run(() => super.unregisterNutrition(date, mealType, payload));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
