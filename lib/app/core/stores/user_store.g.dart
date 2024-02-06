// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on UserStoreBase, Store {
  late final _$registerPhysicalActivityAsyncAction =
      AsyncAction('UserStoreBase.registerPhysicalActivity', context: context);

  @override
  Future<void> registerPhysicalActivity(
      DateTime date, RegisterPhysicalActivityPayloadModel payload) {
    return _$registerPhysicalActivityAsyncAction
        .run(() => super.registerPhysicalActivity(date, payload));
  }

  late final _$registerNutritionAsyncAction =
      AsyncAction('UserStoreBase.registerNutrition', context: context);

  @override
  Future<void> registerNutrition(
      DateTime date, RegisterNutritionPayloadModel payload) {
    return _$registerNutritionAsyncAction
        .run(() => super.registerNutrition(date, payload));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
