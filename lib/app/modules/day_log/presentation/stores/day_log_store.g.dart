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

  late final _$energyAtom =
      Atom(name: 'DayLogStoreBase.energy', context: context);

  @override
  double? get energy {
    _$energyAtom.reportRead();
    return super.energy;
  }

  @override
  set energy(double? value) {
    _$energyAtom.reportWrite(value, super.energy, () {
      super.energy = value;
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

  late final _$timeOfDayAtom =
      Atom(name: 'DayLogStoreBase.timeOfDay', context: context);

  @override
  TimeOfDay? get timeOfDay {
    _$timeOfDayAtom.reportRead();
    return super.timeOfDay;
  }

  @override
  set timeOfDay(TimeOfDay? value) {
    _$timeOfDayAtom.reportWrite(value, super.timeOfDay, () {
      super.timeOfDay = value;
    });
  }

  late final _$nutritionsAtom =
      Atom(name: 'DayLogStoreBase.nutritions', context: context);

  @override
  List<NutritionWithEnergyModel>? get nutritions {
    _$nutritionsAtom.reportRead();
    return super.nutritions;
  }

  @override
  set nutritions(List<NutritionWithEnergyModel>? value) {
    _$nutritionsAtom.reportWrite(value, super.nutritions, () {
      super.nutritions = value;
    });
  }

  @override
  String toString() {
    return '''
physicalActivity: ${physicalActivity},
energy: ${energy},
mealType: ${mealType},
timeOfDay: ${timeOfDay},
nutritions: ${nutritions}
    ''';
  }
}
