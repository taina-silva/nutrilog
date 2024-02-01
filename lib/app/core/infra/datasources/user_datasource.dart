import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilog/app/core/errors/exceptions.dart';
import 'package:nutrilog/app/core/infra/models/register_physical_activity_payload_model.dart';
import 'package:nutrilog/app/core/services/local_storage/local_storage_service.dart';
import 'package:nutrilog/app/core/utils/storage_keys.dart';

abstract class UserDatasource {
  Future<List<RegisterPhysicalActivityPayloadModel>> getPhysicalActivitiesByDate(DateTime date);
  Future<void> registerPhysicalActivityAtDate(
      DateTime date, RegisterPhysicalActivityPayloadModel payload);
}

class UserDatasourceImpl implements UserDatasource {
  final FirebaseFirestore _firestore;
  final LocalStorage _localStorage;

  UserDatasourceImpl(this._firestore, this._localStorage);

  @override
  Future<List<RegisterPhysicalActivityPayloadModel>> getPhysicalActivitiesByDate(
      DateTime date) async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);

      if (userId == null) throw const NoPermissionsException();

      QuerySnapshot snapshot = await _firestore
          .collection('users/$userId/physical-activities')
          .where('date', isEqualTo: date.millisecondsSinceEpoch.toString())
          .get();
      List<RegisterPhysicalActivityPayloadModel> docs =
          ((snapshot.docs.first.data() as Map<String, dynamic>)['physical-activities'] as List)
              .map((pA) => RegisterPhysicalActivityPayloadModel.fromMap(pA))
              .toList();

      return docs;
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> registerPhysicalActivityAtDate(
      DateTime date, RegisterPhysicalActivityPayloadModel payload) async {
    try {
      String? userId = await _localStorage.read<String>(StorageKeys.userId);

      if (userId == null) throw const NoPermissionsException();

      List<RegisterPhysicalActivityPayloadModel> registered =
          await getPhysicalActivitiesByDate(date);
      registered.add(payload);

      String physicalActivityDocId = date.millisecondsSinceEpoch.toString();

      await _firestore
          .doc('users/$userId')
          .collection('physical-activities')
          .doc(physicalActivityDocId)
          .set(
        {
          'date': date.millisecondsSinceEpoch.toString(),
          'physical-activities': registered.map((e) => e.toMap()).toList()
        },
      );
    } catch (exception) {
      rethrow;
    }
  }
}
