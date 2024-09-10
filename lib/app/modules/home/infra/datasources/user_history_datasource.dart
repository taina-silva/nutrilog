import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilog/app/core/errors/exceptions/auth.dart';
import 'package:nutrilog/app/core/errors/exceptions/user_history.dart';
import 'package:nutrilog/app/core/infra/models/day_log/day_log_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_by_meal_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/core/services/local_storage/local_storage_service.dart';
import 'package:nutrilog/app/core/utils/storage_keys.dart';
import 'package:nutrilog/app/core/utils/time_of_day.dart';

abstract class UserHistoryDatasource {
  Future<List<DayLogModel>> getHistory();
  Future<void> registerPhysicalActivityAtDate(
      DateTime date, PhysicalActivityWithDurationModel payload);
  Future<void> registerNutritionAtDate(DateTime date, NutritionsByMealModel payload);
  Future<void> unregisterPhysicalActivityAtDate(
      DateTime date, PhysicalActivityWithDurationModel payload);
  Future<void> unregisterNutritionAtDate(DateTime date, NutritionsByMealModel payload);
}

class UserHistoryDatasourceImpl implements UserHistoryDatasource {
  final FirebaseFirestore _firestore;
  final LocalStorage _localStorage;

  UserHistoryDatasourceImpl(this._firestore, this._localStorage);

  @override
  Future<List<DayLogModel>> getHistory() async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);
      if (userId == null) throw const NoPermissionsException();

      QuerySnapshot snapshot = await _firestore.collection('users/$userId/day-log').get();
      if (snapshot.docs.isEmpty) return [];

      List<DayLogModel> list = snapshot.docs.map((e) {
        return DayLogModel.fromMap(e.data() as Map<String, dynamic>);
      }).toList();

      list.sort((a, b) => b.date.compareTo(a.date));
      return list;
    } catch (exception) {
      throw const GetUserHistoryException();
    }
  }

  @override
  Future<void> registerPhysicalActivityAtDate(
      DateTime date, PhysicalActivityWithDurationModel payload) async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);
      if (userId == null) throw const NoPermissionsException();

      await _firestore
          .collection('users/$userId/day-log')
          .doc(date.millisecondsSinceEpoch.toString())
          .set(
        {
          'date': date.millisecondsSinceEpoch,
          'physical-activities': FieldValue.arrayUnion([payload.toMap()]),
        },
        SetOptions(merge: true),
      );
    } catch (exception) {
      throw const RegisterPhysicalActivityException();
    }
  }

  @override
  Future<void> registerNutritionAtDate(DateTime date, NutritionsByMealModel payload) async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);
      if (userId == null) throw const NoPermissionsException();

      await _firestore
          .collection('users/$userId/day-log')
          .doc(date.millisecondsSinceEpoch.toString())
          .set(
        {
          'date': date.millisecondsSinceEpoch,
          payload.meal.key: {
            if (payload.time != null) 'time': timeOfDayAsStr(payload.time!),
            if (payload.energy != 0) 'energy': payload.energy,
            'nutritions': FieldValue.arrayUnion(payload.nutritions.map((e) => e.toMap()).toList()),
          },
        },
        SetOptions(merge: true),
      );
    } catch (exception) {
      throw const RegisterNutritionException();
    }
  }

  @override
  Future<void> unregisterPhysicalActivityAtDate(
      DateTime date, PhysicalActivityWithDurationModel payload) async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);
      if (userId == null) throw const NoPermissionsException();

      await _firestore
          .collection('users/$userId/day-log')
          .doc(date.millisecondsSinceEpoch.toString())
          .set(
        {
          'physicalActivities': FieldValue.arrayRemove([payload.toMap()]),
        },
        SetOptions(merge: true),
      );
    } catch (exception) {
      throw const UnregisterPhysicalActivityException();
    }
  }

  @override
  Future<void> unregisterNutritionAtDate(DateTime date, NutritionsByMealModel payload) async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);
      if (userId == null) throw const NoPermissionsException();

      await _firestore
          .collection('users/$userId/day-log')
          .doc(date.millisecondsSinceEpoch.toString())
          .set(
        {
          payload.meal.key: {
            'nutritions': FieldValue.arrayRemove(payload.nutritions.map((e) => e.toMap()).toList()),
          }
        },
        SetOptions(merge: true),
      );
    } catch (exception) {
      throw const UnregisterNutritionException();
    }
  }
}
