// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutritions_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NutritionsStore on NutritionsStoreBase, Store {
  late final _$_stateAtom =
      Atom(name: 'NutritionsStoreBase._state', context: context);

  GetNutritionsState get state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  GetNutritionsState get _state => state;

  @override
  set _state(GetNutritionsState value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  late final _$getAllNutritionsAsyncAction =
      AsyncAction('NutritionsStoreBase.getAllNutritions', context: context);

  @override
  Future<void> getAllNutritions() {
    return _$getAllNutritionsAsyncAction.run(() => super.getAllNutritions());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
