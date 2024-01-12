import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutrilog/app/core/errors/exceptions.dart';
import 'package:nutrilog/app/modules/access/infra/models/auth_payload_model.dart';

abstract class AuthDatasource {
  Future<void> signup(AuthPayloadModel payload);
  Future<void> login(AuthPayloadModel payload);
}

class FirebaseAuthDatasource implements AuthDatasource {
  final FirebaseAuth _auth;

  FirebaseAuthDatasource(this._auth);

  @override
  Future<void> signup(AuthPayloadModel payload) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: payload.email, password: payload.password);
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
  Future<void> login(AuthPayloadModel payload) async {
    try {
      await _auth.signInWithEmailAndPassword(email: payload.email, password: payload.password);
    } on FirebaseAuthException catch (exception) {
      if (exception.code == "user-not-found") {
        throw const UserNotFoundException();
      } else if (exception.code == "invalid-email") {
        throw const InvalidEmailException();
      } else if (exception.code == "wrong-password") {
        throw const WrongPasswordException();
      } else {
        rethrow;
      }
    }
  }
}
