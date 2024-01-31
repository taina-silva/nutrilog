import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilog/app/core/errors/exceptions.dart';
import 'package:nutrilog/app/core/infra/models/auth_payload_model.dart';

abstract class AuthDatasource {
  Future<void> signup(AuthPayloadModel payload);
  Future<String?> signin(AuthPayloadModel payload);
  Future<void> signout();
}

class FirebaseAuthDatasource implements AuthDatasource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FirebaseAuthDatasource(this._auth, this._firestore);

  @override
  Future<void> signup(AuthPayloadModel payload) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: payload.email, password: payload.password);

      if (user.user == null) return;

      var userUid = user.user!.uid;
      var account = {userUid: userUid, 'physicalActivities': [], 'nutrition': []};

      await _firestore.collection('users').doc(userUid).set(account);
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
  Future<String?> signin(AuthPayloadModel payload) async {
    try {
      UserCredential response =
          await _auth.signInWithEmailAndPassword(email: payload.email, password: payload.password);

      return response.user?.uid;
    } on FirebaseAuthException catch (exception) {
      if (exception.code == "USER_NOT_FOUND") {
        throw const UserNotFoundException();
      } else if (exception.code == "INVALID_LOGIN_CREDENTIALS") {
        throw const InvalidLoginCredentialsException();
      } else if (exception.code == "WRONG_PASSWORD") {
        throw const WrongPasswordException();
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (exception) {
      rethrow;
    }
  }
}
