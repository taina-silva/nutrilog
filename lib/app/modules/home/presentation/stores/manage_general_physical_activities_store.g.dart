// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_general_physical_activities_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ManageGeneralPhysicalActivitiesStore
    on ManageGeneralPhysicalActivitiesStoreBase, Store {
  late final _$physicalActivitiesAtom = Atom(
      name: 'ManageGeneralPhysicalActivitiesStoreBase.physicalActivities',
      context: context);

  @override
  ObservableList<ListPhysicalActivitiesModel> get physicalActivities {
    _$physicalActivitiesAtom.reportRead();
    return super.physicalActivities;
  }

  @override
  set physicalActivities(ObservableList<ListPhysicalActivitiesModel> value) {
    _$physicalActivitiesAtom.reportWrite(value, super.physicalActivities, () {
      super.physicalActivities = value;
    });
  }

  late final _$afterSearchAtom = Atom(
      name: 'ManageGeneralPhysicalActivitiesStoreBase.afterSearch',
      context: context);

  @override
  ObservableList<ListPhysicalActivitiesModel> get afterSearch {
    _$afterSearchAtom.reportRead();
    return super.afterSearch;
  }

  @override
  set afterSearch(ObservableList<ListPhysicalActivitiesModel> value) {
    _$afterSearchAtom.reportWrite(value, super.afterSearch, () {
      super.afterSearch = value;
    });
  }

  late final _$_stateAtom = Atom(
      name: 'ManageGeneralPhysicalActivitiesStoreBase._state',
      context: context);

  ManageGeneralPhysicalActivitiesState get state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  ManageGeneralPhysicalActivitiesState get _state => state;

  @override
  set _state(ManageGeneralPhysicalActivitiesState value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  late final _$getGeneralPhysicalActivitiesAsyncAction = AsyncAction(
      'ManageGeneralPhysicalActivitiesStoreBase.getGeneralPhysicalActivities',
      context: context);

  @override
  Future<void> getGeneralPhysicalActivities() {
    return _$getGeneralPhysicalActivitiesAsyncAction
        .run(() => super.getGeneralPhysicalActivities());
  }

  late final _$registerNewPhysicalActivityAsyncAction = AsyncAction(
      'ManageGeneralPhysicalActivitiesStoreBase.registerNewPhysicalActivity',
      context: context);

  @override
  Future<void> registerNewPhysicalActivity(String type, String name) {
    return _$registerNewPhysicalActivityAsyncAction
        .run(() => super.registerNewPhysicalActivity(type, name));
  }

  late final _$ManageGeneralPhysicalActivitiesStoreBaseActionController =
      ActionController(
          name: 'ManageGeneralPhysicalActivitiesStoreBase', context: context);

  @override
  void onSearch(String value) {
    final _$actionInfo =
        _$ManageGeneralPhysicalActivitiesStoreBaseActionController.startAction(
            name: 'ManageGeneralPhysicalActivitiesStoreBase.onSearch');
    try {
      return super.onSearch(value);
    } finally {
      _$ManageGeneralPhysicalActivitiesStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
physicalActivities: ${physicalActivities},
afterSearch: ${afterSearch}
    ''';
  }
}
