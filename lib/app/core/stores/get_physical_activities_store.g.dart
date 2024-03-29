// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_physical_activities_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GetPhysicalActivityStore on GetPhysicalActivityStoreBase, Store {
  late final _$_stateAtom =
      Atom(name: 'GetPhysicalActivityStoreBase._state', context: context);

  GetPhysicalActivitiesState get state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  GetPhysicalActivitiesState get _state => state;

  @override
  set _state(GetPhysicalActivitiesState value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  late final _$_afterSearchAtom =
      Atom(name: 'GetPhysicalActivityStoreBase._afterSearch', context: context);

  List<ListPhysicalActivitiesModel> get afterSearch {
    _$_afterSearchAtom.reportRead();
    return super._afterSearch;
  }

  @override
  List<ListPhysicalActivitiesModel> get _afterSearch => afterSearch;

  @override
  set _afterSearch(List<ListPhysicalActivitiesModel> value) {
    _$_afterSearchAtom.reportWrite(value, super._afterSearch, () {
      super._afterSearch = value;
    });
  }

  late final _$getAllPhysicalActivitiesAsyncAction = AsyncAction(
      'GetPhysicalActivityStoreBase.getAllPhysicalActivities',
      context: context);

  @override
  Future<void> getAllPhysicalActivities() {
    return _$getAllPhysicalActivitiesAsyncAction
        .run(() => super.getAllPhysicalActivities());
  }

  late final _$GetPhysicalActivityStoreBaseActionController =
      ActionController(name: 'GetPhysicalActivityStoreBase', context: context);

  @override
  void onSearch(String value) {
    final _$actionInfo = _$GetPhysicalActivityStoreBaseActionController
        .startAction(name: 'GetPhysicalActivityStoreBase.onSearch');
    try {
      return super.onSearch(value);
    } finally {
      _$GetPhysicalActivityStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
