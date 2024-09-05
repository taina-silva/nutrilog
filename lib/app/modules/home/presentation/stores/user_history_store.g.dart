// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_history_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserHistoryStore on UserHistoryStoreBase, Store {
  late final _$_getHistoryStateAtom =
      Atom(name: 'UserHistoryStoreBase._getHistoryState', context: context);

  GetHistoryState get getHistoryState {
    _$_getHistoryStateAtom.reportRead();
    return super._getHistoryState;
  }

  @override
  GetHistoryState get _getHistoryState => getHistoryState;

  @override
  set _getHistoryState(GetHistoryState value) {
    _$_getHistoryStateAtom.reportWrite(value, super._getHistoryState, () {
      super._getHistoryState = value;
    });
  }

  late final _$_managePhysicalActivityStateAtom = Atom(
      name: 'UserHistoryStoreBase._managePhysicalActivityState',
      context: context);

  ManagePhysicalActivityState get managePhysicalActivityState {
    _$_managePhysicalActivityStateAtom.reportRead();
    return super._managePhysicalActivityState;
  }

  @override
  ManagePhysicalActivityState get _managePhysicalActivityState =>
      managePhysicalActivityState;

  @override
  set _managePhysicalActivityState(ManagePhysicalActivityState value) {
    _$_managePhysicalActivityStateAtom
        .reportWrite(value, super._managePhysicalActivityState, () {
      super._managePhysicalActivityState = value;
    });
  }

  late final _$_manageNutritionStateAtom = Atom(
      name: 'UserHistoryStoreBase._manageNutritionState', context: context);

  ManageNutritionState get manageNutritionState {
    _$_manageNutritionStateAtom.reportRead();
    return super._manageNutritionState;
  }

  @override
  ManageNutritionState get _manageNutritionState => manageNutritionState;

  @override
  set _manageNutritionState(ManageNutritionState value) {
    _$_manageNutritionStateAtom.reportWrite(value, super._manageNutritionState,
        () {
      super._manageNutritionState = value;
    });
  }

  late final _$getHistoryAsyncAction =
      AsyncAction('UserHistoryStoreBase.getHistory', context: context);

  @override
  Future<void> getHistory() {
    return _$getHistoryAsyncAction.run(() => super.getHistory());
  }

  late final _$registerPhysicalActivityAsyncAction = AsyncAction(
      'UserHistoryStoreBase.registerPhysicalActivity',
      context: context);

  @override
  Future<void> registerPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel payload) {
    return _$registerPhysicalActivityAsyncAction
        .run(() => super.registerPhysicalActivity(date, payload));
  }

  late final _$registerNutritionAsyncAction =
      AsyncAction('UserHistoryStoreBase.registerNutrition', context: context);

  @override
  Future<void> registerNutrition(DateTime date, NutritionsByMealModel payload) {
    return _$registerNutritionAsyncAction
        .run(() => super.registerNutrition(date, payload));
  }

  late final _$unregisterPhysicalActivityAsyncAction = AsyncAction(
      'UserHistoryStoreBase.unregisterPhysicalActivity',
      context: context);

  @override
  Future<void> unregisterPhysicalActivity(
      DateTime date, PhysicalActivityWithDurationModel payload) {
    return _$unregisterPhysicalActivityAsyncAction
        .run(() => super.unregisterPhysicalActivity(date, payload));
  }

  late final _$unregisterNutritionAsyncAction =
      AsyncAction('UserHistoryStoreBase.unregisterNutrition', context: context);

  @override
  Future<void> unregisterNutrition(
      DateTime date, NutritionsByMealModel payload) {
    return _$unregisterNutritionAsyncAction
        .run(() => super.unregisterNutrition(date, payload));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
