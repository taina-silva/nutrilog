import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilog/app/core/errors/exceptions.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/day_log/day_log_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_by_meals_of_day_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_one_meal_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/core/services/local_storage/local_storage_service.dart';
import 'package:nutrilog/app/core/utils/storage_keys.dart';

abstract class UserDatasource {
  Future<List<DayLogModel>?> getDayLogList();
  Future<List<PhysicalActivityWithDurationModel>> getPhysicalActivitiesByDate(DateTime date);
  Future<NutritionsByMealOfDayModel?> getNutritionsByDate(DateTime date);
  Future<void> registerPhysicalActivityAtDate(
      DateTime date, PhysicalActivityWithDurationModel payload);
  Future<void> registerNutritionAtDate(DateTime date, NutritionsOneMealModel payload);
  Future<void> unregisterPhysicalActivityAtDate(
      DateTime date, PhysicalActivityWithDurationModel payload);
  Future<void> unregisterNutritionAtDate(
      DateTime date, MealType mealType, NutritionWithEnergyModel payload);
}

class UserDatasourceImpl implements UserDatasource {
  final FirebaseFirestore _firestore;
  final LocalStorage _localStorage;

  UserDatasourceImpl(this._firestore, this._localStorage);

  @override
  Future<List<DayLogModel>?> getDayLogList() async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);

      if (userId == null) throw const NoPermissionsException();

      QuerySnapshot snapshot = await _firestore.collection('users/$userId/day-log').get();

      if (snapshot.docs.isEmpty) return null;

      List<DayLogModel> list = snapshot.docs.map((e) {
        return DayLogModel.fromMap(e.data() as Map<String, dynamic>);
      }).toList();

      list.sort((a, b) => b.date.compareTo(a.date));

      return list;
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<List<PhysicalActivityWithDurationModel>> getPhysicalActivitiesByDate(DateTime date) async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);

      if (userId == null) throw const NoPermissionsException();

      QuerySnapshot snapshot = await _firestore
          .collection('users/$userId/day-log')
          .where('date', isEqualTo: date.millisecondsSinceEpoch.toString())
          .get();

      if (snapshot.docs.isEmpty ||
          (snapshot.docs.first.data() as Map<String, dynamic>)['physical-activities'] == null) {
        return [];
      }

      List<PhysicalActivityWithDurationModel> docs =
          ((snapshot.docs.first.data() as Map<String, dynamic>)['physical-activities'] as List)
              .map((pA) => PhysicalActivityWithDurationModel.fromMap(pA))
              .toList();

      return docs;
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<NutritionsByMealOfDayModel?> getNutritionsByDate(DateTime date) async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);

      if (userId == null) throw const NoPermissionsException();

      QuerySnapshot snapshot = await _firestore
          .collection('users/$userId/day-log')
          .where('date', isEqualTo: date.millisecondsSinceEpoch.toString())
          .get();

      if (snapshot.docs.isEmpty ||
          (snapshot.docs.first.data() as Map<String, dynamic>)['nutrition'] == null) return null;

      NutritionsByMealOfDayModel docs = NutritionsByMealOfDayModel.fromMap(
          (snapshot.docs.first.data() as Map<String, dynamic>)['nutrition']);

      return docs;
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> registerPhysicalActivityAtDate(
      DateTime date, PhysicalActivityWithDurationModel payload) async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);

      if (userId == null) throw const NoPermissionsException();

      List<PhysicalActivityWithDurationModel> registered =
          List.from(await getPhysicalActivitiesByDate(date));
      registered.add(payload);

      String id = date.millisecondsSinceEpoch.toString();

      await _firestore.doc('users/$userId').collection('day-log').doc(id).set({
        'date': date.millisecondsSinceEpoch.toString(),
        'physical-activities': registered.map((e) => e.toMap()).toList()
      }, SetOptions(merge: true));
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> registerNutritionAtDate(DateTime date, NutritionsOneMealModel payload) async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);

      if (userId == null) throw const NoPermissionsException();

      NutritionsByMealOfDayModel? registered = (await getNutritionsByDate(date))?.copyWith();

      if (registered != null) {
        if (registered.nutritions[payload.mealType] == null) {
          registered.nutritions[payload.mealType] = payload;
        } else {
          NutritionsOneMealModel old = registered.nutritions[payload.mealType]!;
          registered.nutritions[payload.mealType] = payload.copyWith(
              nutritions: old.nutritions + payload.nutritions, energy: old.energy + payload.energy);
        }
      } else {
        registered = NutritionsByMealOfDayModel(nutritions: {payload.mealType: payload});
      }

      String id = date.millisecondsSinceEpoch.toString();

      await _firestore.doc('users/$userId').collection('day-log').doc(id).set({
        'date': date.millisecondsSinceEpoch.toString(),
        'nutrition': registered.toMap(),
      }, SetOptions(merge: true));
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> unregisterPhysicalActivityAtDate(
      DateTime date, PhysicalActivityWithDurationModel payload) async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);

      if (userId == null) throw const NoPermissionsException();

      List<PhysicalActivityWithDurationModel> registered =
          List.from(await getPhysicalActivitiesByDate(date));
      registered.removeWhere((e) => e == payload);

      String id = date.millisecondsSinceEpoch.toString();

      await _firestore.doc('users/$userId').collection('day-log').doc(id).set({
        'date': date.millisecondsSinceEpoch.toString(),
        'physical-activities': registered.map((e) => e.toMap()).toList()
      }, SetOptions(merge: true));
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> unregisterNutritionAtDate(
      DateTime date, MealType mealType, NutritionWithEnergyModel payload) async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);

      if (userId == null) throw const NoPermissionsException();

      NutritionsByMealOfDayModel? registered = (await getNutritionsByDate(date))?.copyWith();

      if (registered == null) return;
      if (registered.nutritions[mealType] == null) return;

      Map<MealType, NutritionsOneMealModel> nutritions = Map.from(registered.nutritions);
      NutritionsOneMealModel old = nutritions[mealType]!;
      old.nutritions.removeWhere((e) => e == payload);

      NutritionsByMealOfDayModel newRegistration = registered.copyWith(nutritions: nutritions);

      String id = date.millisecondsSinceEpoch.toString();

      await _firestore.doc('users/$userId').collection('day-log').doc(id).set({
        'date': date.millisecondsSinceEpoch.toString(),
        'nutrition': newRegistration.toMap(),
      }, SetOptions(merge: true));
    } catch (exception) {
      rethrow;
    }
  }
}
