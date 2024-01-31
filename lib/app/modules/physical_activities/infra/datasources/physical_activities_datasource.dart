import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilog/app/core/errors/exceptions.dart';
import 'package:nutrilog/app/core/services/local_storage/local_storage_service.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/models/physical_activity_model.dart';

abstract class AuthDatasource {
  Future<List<PhysicalActivityModel>> getAllPhysicalActivities();
  Future<List<PhysicalActivityModel>> getPhysicalActivitiesByUser();
}

class FirebaseAuthDatasource implements AuthDatasource {
  final FirebaseFirestore _firestore;
  final LocalStorage _localStorage;

  FirebaseAuthDatasource(this._firestore, this._localStorage);

  @override
  Future<List<PhysicalActivityModel>> getAllPhysicalActivities() async {
    try {
      var snapshot = await _firestore.collection('physical-activities').get();
      var docs = snapshot.docs.map((doc) => doc.data()).toList();
      return [];
    } on FirebaseAuthException catch (exception) {
      if (exception.code == "email-already-in-use") {
        throw const EmailAlreadyInUseException();
      } else if (exception.code == "invalid-email") {
        throw const InvalidEmailException();
      } else if (exception.code == "weak-password") {
        throw const WeakPasswordException();
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<List<PhysicalActivityModel>> getPhysicalActivitiesByUser() async {
    try {
      var snapshot = await _firestore.collection('physical-activities').get();
      return [];
    } on FirebaseAuthException catch (exception) {
      if (exception.code == "email-already-in-use") {
        throw const EmailAlreadyInUseException();
      } else if (exception.code == "invalid-email") {
        throw const InvalidEmailException();
      } else if (exception.code == "weak-password") {
        throw const WeakPasswordException();
      } else {
        rethrow;
      }
    }
  }
}
