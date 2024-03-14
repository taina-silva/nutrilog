import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/list_physical_activities_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_model.dart';

abstract class PhysicalActivityDatasource {
  Future<List<ListPhysicalActivitiesModel>> getAllPhysicalActivities();
  Future<void> registerNewPhysicalActivity(PhysicalActivityModel payload);
}

class PhysicalActivityDatasourceImpl implements PhysicalActivityDatasource {
  final FirebaseFirestore _firestore;

  PhysicalActivityDatasourceImpl(this._firestore);

  @override
  Future<List<ListPhysicalActivitiesModel>> getAllPhysicalActivities() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('physical-activities').get();
      List<ListPhysicalActivitiesModel> pA = snapshot.docs
          .where((doc) => doc.id != 'types')
          .map((doc) => ListPhysicalActivitiesModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return pA;
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> registerNewPhysicalActivity(PhysicalActivityModel payload) async {
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
