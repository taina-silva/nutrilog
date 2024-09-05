// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_history_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DailyHistoryStore on DailyHistoryStoreBase, Store {
  late final _$selectedDateAtom =
      Atom(name: 'DailyHistoryStoreBase.selectedDate', context: context);

  @override
  DateTime? get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime? value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  late final _$physicalActivitiesAtom =
      Atom(name: 'DailyHistoryStoreBase.physicalActivities', context: context);

  @override
  ObservableList<PhysicalActivityWithDurationModel> get physicalActivities {
    _$physicalActivitiesAtom.reportRead();
    return super.physicalActivities;
  }

  @override
  set physicalActivities(
      ObservableList<PhysicalActivityWithDurationModel> value) {
    _$physicalActivitiesAtom.reportWrite(value, super.physicalActivities, () {
      super.physicalActivities = value;
    });
  }

  late final _$nutritionsAtom =
      Atom(name: 'DailyHistoryStoreBase.nutritions', context: context);

  @override
  ObservableList<NutritionsByMealModel> get nutritions {
    _$nutritionsAtom.reportRead();
    return super.nutritions;
  }

  @override
  set nutritions(ObservableList<NutritionsByMealModel> value) {
    _$nutritionsAtom.reportWrite(value, super.nutritions, () {
      super.nutritions = value;
    });
  }

  late final _$DailyHistoryStoreBaseActionController =
      ActionController(name: 'DailyHistoryStoreBase', context: context);

  @override
  void getPhysicalActivities(DateTime date) {
    final _$actionInfo = _$DailyHistoryStoreBaseActionController.startAction(
        name: 'DailyHistoryStoreBase.getPhysicalActivities');
    try {
      return super.getPhysicalActivities(date);
    } finally {
      _$DailyHistoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getNutritions(DateTime date) {
    final _$actionInfo = _$DailyHistoryStoreBaseActionController.startAction(
        name: 'DailyHistoryStoreBase.getNutritions');
    try {
      return super.getNutritions(date);
    } finally {
      _$DailyHistoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedDate: ${selectedDate},
physicalActivities: ${physicalActivities},
nutritions: ${nutritions}
    ''';
  }
}
