import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/models/physical_activity_model.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/models/physical_activity_type_model.dart';
import 'package:uuid/uuid.dart';

abstract class PhysicalActivitiesDatasource {
  Future<Tuple2<List<PhysicalActivityTypeModel>, List<PhysicalActivityModel>>>
      getAllPhysicalActivities();
  Future<void> registerNewPhysicalActivity(PhysicalActivityModel payload);
}

class PhysicalActivitiesDatasourceImpl implements PhysicalActivitiesDatasource {
  final FirebaseFirestore _firestore;

  PhysicalActivitiesDatasourceImpl(this._firestore);

  @override
  Future<Tuple2<List<PhysicalActivityTypeModel>, List<PhysicalActivityModel>>>
      getAllPhysicalActivities() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('physical-activities').get();
      List<PhysicalActivityTypeModel> types = ((snapshot.docs
              .firstWhere((doc) => doc.id == 'types')
              .data() as Map<String, dynamic>)['types'] as List<String>)
          .map((t) => PhysicalActivityTypeModel(type: t))
          .toList();
      List<PhysicalActivityModel> pA = snapshot.docs
          .map((doc) => PhysicalActivityModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return Tuple2(types, pA);
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> registerNewPhysicalActivity(PhysicalActivityModel payload) async {
    try {
      _firestore.collection('physical-activities').doc(const Uuid().v4()).set(payload.toMap());
    } catch (exception) {
      rethrow;
    }
  }
}
