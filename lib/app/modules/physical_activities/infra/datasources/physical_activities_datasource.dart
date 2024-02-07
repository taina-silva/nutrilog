import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/models/physical_activity_model.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/models/physical_activity_type_model.dart';

abstract class PhysicalActivitiesDatasource {
  Future<List<PhysicalActivitiesModel>> getAllPhysicalActivities();
  Future<void> registerNewPhysicalActivity(UniquePhysicalActivityModel payload);
}

class PhysicalActivitiesDatasourceImpl implements PhysicalActivitiesDatasource {
  final FirebaseFirestore _firestore;

  PhysicalActivitiesDatasourceImpl(this._firestore);

  @override
  Future<List<PhysicalActivitiesModel>> getAllPhysicalActivities() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('physical-activities').get();
      List<PhysicalActivitiesModel> pA = snapshot.docs
          .where((doc) => doc.id != 'types')
          .map((doc) => PhysicalActivitiesModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return pA;
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> registerNewPhysicalActivity(UniquePhysicalActivityModel payload) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('physical-activities')
          .where("type", isEqualTo: payload.type)
          .get();
      QueryDocumentSnapshot doc = snapshot.docs.first;
      List<String> pA = List.from((doc.data() as Map<String, dynamic>)["physical-activities"]);
      pA.add(payload.name);

      await _firestore.collection('physical-activities').doc(doc.id).set({
        'type': payload.type,
        'physical-activities': pA,
      });
    } catch (exception) {
      rethrow;
    }
  }
}
