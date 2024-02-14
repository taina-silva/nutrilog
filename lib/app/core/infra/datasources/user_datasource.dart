import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilog/app/core/errors/exceptions.dart';
import 'package:nutrilog/app/core/infra/models/day_log_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_by_meals_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_for_meal_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/core/services/local_storage/local_storage_service.dart';
import 'package:nutrilog/app/core/utils/storage_keys.dart';

abstract class UserDatasource {
  Future<List<DayLogModel>?> getDayLogList();
  Future<List<PhysicalActivityWithDurationModel>> getPhysicalActivitiesByDate(DateTime date);
  Future<NutritionsByMealsModel?> getNutritionsByDate(DateTime date);
  Future<void> registerPhysicalActivityAtDate(
      DateTime date, PhysicalActivityWithDurationModel payload);
  Future<void> registerNutritionAtDate(DateTime date, NutritionsForMealModel payload);
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

      if (snapshot.docs.isEmpty) return [];

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
  Future<NutritionsByMealsModel?> getNutritionsByDate(DateTime date) async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);

      if (userId == null) throw const NoPermissionsException();

      QuerySnapshot snapshot = await _firestore
          .collection('users/$userId/day-log')
          .where('date', isEqualTo: date.millisecondsSinceEpoch.toString())
          .get();

      if (snapshot.docs.isEmpty) return null;

      NutritionsByMealsModel docs = NutritionsByMealsModel.fromMap(
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

      List<PhysicalActivityWithDurationModel> registered = await getPhysicalActivitiesByDate(date);
      registered.add(payload);

      String physicalActivityDocId = date.millisecondsSinceEpoch.toString();

      await _firestore.doc('users/$userId').collection('day-log').doc(physicalActivityDocId).set(
        {
          'date': date.millisecondsSinceEpoch.toString(),
          'physical-activities': registered.map((e) => e.toMap()).toList()
        },
      );
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> registerNutritionAtDate(DateTime date, NutritionsForMealModel payload) async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);

      if (userId == null) throw const NoPermissionsException();

      NutritionsByMealsModel? registered = await getNutritionsByDate(date);

      if (registered != null) {
        registered.nutritions[payload.mealType] ??= [];
        registered.nutritions[payload.mealType] =
            registered.nutritions[payload.mealType]! + payload.nutritions;
      } else {
        registered = NutritionsByMealsModel(energy: payload.energy, nutritions: {
          payload.mealType: payload.nutritions,
        });
      }

      String physicalActivityDocId = date.millisecondsSinceEpoch.toString();

      await _firestore.doc('users/$userId').collection('day-log').doc(physicalActivityDocId).set(
        {
          'date': date.millisecondsSinceEpoch.toString(),
          'nutrition': registered.toMap(),
        },
      );
    } catch (exception) {
      rethrow;
    }
  }
}
