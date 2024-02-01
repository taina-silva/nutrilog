import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilog/app/core/services/local_storage/local_storage_service.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/models/physical_activity_model.dart';

abstract class PhysicalActivitiesDatasource {
  Future<List<PhysicalActivityModel>> getAllPhysicalActivities();
  Future<List<PhysicalActivityModel>> getPhysicalActivitiesByUser();
}

class PhysicalActivitiesDatasourceImpl implements PhysicalActivitiesDatasource {
  final FirebaseFirestore _firestore;
  final LocalStorage _localStorage;

  PhysicalActivitiesDatasourceImpl(this._firestore, this._localStorage);

  @override
  Future<List<PhysicalActivityModel>> getAllPhysicalActivities() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('physical-activities').get();
      List<PhysicalActivityModel> docs = snapshot.docs
          .map((doc) => PhysicalActivityModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return docs;
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<List<PhysicalActivityModel>> getPhysicalActivitiesByUser() async {
    try {
      var snapshot = await _firestore.collection('physical-activities').get();
      return [];
    } catch (exception) {
      rethrow;
    }
  }
}
