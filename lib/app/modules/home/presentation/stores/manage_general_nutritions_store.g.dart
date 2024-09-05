// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_general_nutritions_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ManageGeneralNutritionsStore
    on ManageGeneralNutritionsStoreBase, Store {
  late final _$nutritionsAtom = Atom(
      name: 'ManageGeneralNutritionsStoreBase.nutritions', context: context);

  @override
  ObservableList<ListNutritionsModel> get nutritions {
    _$nutritionsAtom.reportRead();
    return super.nutritions;
  }

  @override
  set nutritions(ObservableList<ListNutritionsModel> value) {
    _$nutritionsAtom.reportWrite(value, super.nutritions, () {
      super.nutritions = value;
    });
  }

  late final _$afterSearchAtom = Atom(
      name: 'ManageGeneralNutritionsStoreBase.afterSearch', context: context);

  @override
  ObservableList<ListNutritionsModel> get afterSearch {
    _$afterSearchAtom.reportRead();
    return super.afterSearch;
  }

  @override
  set afterSearch(ObservableList<ListNutritionsModel> value) {
    _$afterSearchAtom.reportWrite(value, super.afterSearch, () {
      super.afterSearch = value;
    });
  }

  late final _$_stateAtom =
      Atom(name: 'ManageGeneralNutritionsStoreBase._state', context: context);

  ManageGeneralNutritionsState get state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  ManageGeneralNutritionsState get _state => state;

  @override
  set _state(ManageGeneralNutritionsState value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  late final _$getGeneralNutritionsAsyncAction = AsyncAction(
      'ManageGeneralNutritionsStoreBase.getGeneralNutritions',
      context: context);

  @override
  Future<void> getGeneralNutritions() {
    return _$getGeneralNutritionsAsyncAction
        .run(() => super.getGeneralNutritions());
  }

  late final _$registerNewNutritionAsyncAction = AsyncAction(
      'ManageGeneralNutritionsStoreBase.registerNewNutrition',
      context: context);

  @override
  Future<void> registerNewNutrition(String type, String name) {
    return _$registerNewNutritionAsyncAction
        .run(() => super.registerNewNutrition(type, name));
  }

  late final _$ManageGeneralNutritionsStoreBaseActionController =
      ActionController(
          name: 'ManageGeneralNutritionsStoreBase', context: context);

  @override
  void onSearch(String value) {
    final _$actionInfo = _$ManageGeneralNutritionsStoreBaseActionController
        .startAction(name: 'ManageGeneralNutritionsStoreBase.onSearch');
    try {
      return super.onSearch(value);
    } finally {
      _$ManageGeneralNutritionsStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nutritions: ${nutritions},
afterSearch: ${afterSearch}
    ''';
  }
}
