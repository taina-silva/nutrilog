// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_nutrition_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GetNutritionStore on GetNutritionStoreBase, Store {
  late final _$_stateAtom =
      Atom(name: 'GetNutritionStoreBase._state', context: context);

  GetNutritionState get state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  GetNutritionState get _state => state;

  @override
  set _state(GetNutritionState value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  late final _$_afterSearchAtom =
      Atom(name: 'GetNutritionStoreBase._afterSearch', context: context);

  List<ListNutritionsModel> get afterSearch {
    _$_afterSearchAtom.reportRead();
    return super._afterSearch;
  }

  @override
  List<ListNutritionsModel> get _afterSearch => afterSearch;

  @override
  set _afterSearch(List<ListNutritionsModel> value) {
    _$_afterSearchAtom.reportWrite(value, super._afterSearch, () {
      super._afterSearch = value;
    });
  }

  late final _$getAllNutritionsAsyncAction =
      AsyncAction('GetNutritionStoreBase.getAllNutritions', context: context);

  @override
  Future<void> getAllNutritions() {
    return _$getAllNutritionsAsyncAction.run(() => super.getAllNutritions());
  }

  late final _$GetNutritionStoreBaseActionController =
      ActionController(name: 'GetNutritionStoreBase', context: context);

  @override
  void onSearch(String value) {
    final _$actionInfo = _$GetNutritionStoreBaseActionController.startAction(
        name: 'GetNutritionStoreBase.onSearch');
    try {
      return super.onSearch(value);
    } finally {
      _$GetNutritionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
