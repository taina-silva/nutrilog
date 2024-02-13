// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_log_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DayLogStore on DayLogStoreBase, Store {
  late final _$physicalActivityAtom =
      Atom(name: 'DayLogStoreBase.physicalActivity', context: context);

  @override
  PhysicalActivityModel? get physicalActivity {
    _$physicalActivityAtom.reportRead();
    return super.physicalActivity;
  }

  @override
  set physicalActivity(PhysicalActivityModel? value) {
    _$physicalActivityAtom.reportWrite(value, super.physicalActivity, () {
      super.physicalActivity = value;
    });
  }

  late final _$nutritionAtom =
      Atom(name: 'DayLogStoreBase.nutrition', context: context);

  @override
  List<NutritionModel>? get nutrition {
    _$nutritionAtom.reportRead();
    return super.nutrition;
  }

  @override
  set nutrition(List<NutritionModel>? value) {
    _$nutritionAtom.reportWrite(value, super.nutrition, () {
      super.nutrition = value;
    });
  }

  late final _$mealTypeAtom =
      Atom(name: 'DayLogStoreBase.mealType', context: context);

  @override
  MealType? get mealType {
    _$mealTypeAtom.reportRead();
    return super.mealType;
  }

  @override
  set mealType(MealType? value) {
    _$mealTypeAtom.reportWrite(value, super.mealType, () {
      super.mealType = value;
    });
  }

  @override
  String toString() {
    return '''
physicalActivity: ${physicalActivity},
nutrition: ${nutrition},
mealType: ${mealType}
    ''';
  }
}
