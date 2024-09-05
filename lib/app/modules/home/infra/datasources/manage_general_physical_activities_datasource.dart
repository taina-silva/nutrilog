import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilog/app/core/errors/exceptions/general.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/list_physical_activities_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_model.dart';

abstract class ManageGeneralPhysicalActivitiesDatasource {
  Future<List<ListPhysicalActivitiesModel>> getGeneralPhysicalActivities();
  Future<void> registerNewPhysicalActivity(PhysicalActivityModel pA);
}

class ManageGeneralPhysicalActivitiesDatasourceImpl
    implements ManageGeneralPhysicalActivitiesDatasource {
  final FirebaseFirestore _firestore;

  ManageGeneralPhysicalActivitiesDatasourceImpl(this._firestore);

  @override
  Future<List<ListPhysicalActivitiesModel>> getGeneralPhysicalActivities() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('physical-activities').get();
      List<ListPhysicalActivitiesModel> pA = snapshot.docs
          .where((doc) => doc.id != 'types')
          .map((doc) => ListPhysicalActivitiesModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return pA;
    } catch (exception) {
      throw const GetGeneralPhysicalActivitiesException();
    }
  }

  @override
  Future<void> registerNewPhysicalActivity(PhysicalActivityModel pA) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('physical-activities')
          .where("type", isEqualTo: pA.type)
          .get();
      QueryDocumentSnapshot doc = snapshot.docs.first;
      List<String> pAList = List.from((doc.data() as Map<String, dynamic>)["physical-activities"]);
      pAList.add(pA.name);

      await _firestore.collection('physical-activities').doc(doc.id).set({
        'type': pA.type,
        'physical-activities': pAList,
      });
    } catch (exception) {
      throw const RegisterNewPhysicalActivityException();
    }
  }
}
