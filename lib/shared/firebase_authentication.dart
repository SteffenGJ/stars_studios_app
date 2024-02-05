import 'package:firebase_auth/firebase_auth.dart';
import 'package:stars_studios/models/authentication_response.dart';

class FirebaseAuthentication {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthentication({FirebaseAuth? instance})
      : _firebaseAuth = instance ?? FirebaseAuth.instance;

  Future<AuthenticationResponse> createUser(
      Map<String, String> credentials) async {
    try {
      UserCredential credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: credentials["email"]!,
        password: credentials["password"]!,
      );
      return _responseSuccess(userId: credential.user?.uid);
    } on FirebaseAuthException catch (e) {
      return _responseFailure(e);
    }
  }

  Future<AuthenticationResponse> login(Map<String, String> credentials) async {
    try {
      UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: credentials["email"]!,
        password: credentials["password"]!,
      );
      return _responseSuccess(userId: credential.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        return _responseFailure(
          e,
          code: "INVALID_LOGIN_CREDENTIALS",
          message:
              "Invalid login credentials. Please make sure email and password are correct",
        );
      }
      return _responseFailure(e);
    }
  }

  Future<AuthenticationResponse> logout() async {
    try {
      await _firebaseAuth.signOut();
      return _responseSuccess();
    } on FirebaseAuthException catch (e) {
      return _responseFailure(e);
    }
  }

  AuthenticationResponse _responseSuccess({String? userId}) {
    return AuthenticationResponse(
      success: true,
      data: userId != null ? {"userId": userId} : null,
      error: null,
    );
  }

  AuthenticationResponse _responseFailure(FirebaseAuthException error,
      {String? code, String? message}) {
    return AuthenticationResponse(
      success: false,
      data: null,
      error: {"code": code ?? error.code, "message": message ?? error.message},
    );
  }
}
