import 'package:firebase_auth/firebase_auth.dart';
import 'package:stars_studios/controllers/user_controller.dart';
import 'package:stars_studios/models/authentication_data.dart';
import 'package:stars_studios/models/authentication_error.dart';
import 'package:stars_studios/models/authentication_response.dart';

class FirebaseAuthentication {
  final FirebaseAuth _firebaseAuth;
  final UserController _userController;

  FirebaseAuthentication(
      {FirebaseAuth? instance, UserController? userController})
      : _firebaseAuth = instance ?? FirebaseAuth.instance,
        _userController = userController ?? UserController();

  Future<AuthenticationResponse> createUser(
      Map<String, String> credentials) async {
    try {
      return await _signUp(credentials);
    } on FirebaseAuthException catch (e) {
      return _handleAuthException(e);
    }
  }

  Future<AuthenticationResponse> login(Map<String, String> credentials) async {
    try {
      return await _signIn(credentials);
    } on FirebaseAuthException catch (e) {
      return _handleAuthException(e);
    }
  }

  Future<AuthenticationResponse> logout() async {
    try {
      await _firebaseAuth.signOut();
      return _responseSuccess(_firebaseAuth.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      return _responseFailure(e.code, e.message);
    }
  }

  Future<AuthenticationResponse> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return _responseSuccess(_firebaseAuth.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      return _responseFailure(e.code, e.message);
    }
  }

  Future<AuthenticationResponse> changeEmail(String email) async {
    try {
      await _firebaseAuth.currentUser!.verifyBeforeUpdateEmail(email);
      return _responseSuccess(_firebaseAuth.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      return _responseFailure(e.code, e.message);
    }
  }

  AuthenticationResponse _responseSuccess(String userId, {String? email}) {
    return AuthenticationResponse(
      success: true,
      data: AuthenticationData(userId: userId, email: email),
      error: null,
    );
  }

  AuthenticationResponse _responseFailure(
    String code,
    String? message,
  ) {
    return AuthenticationResponse(
      success: false,
      data: null,
      error: AuthenticationError(
        message: message ?? "An error occured",
        code: code,
      ),
    );
  }

  AuthenticationResponse _handleAuthException(FirebaseAuthException e) {
    if (e.code == "INVALID_LOGIN_CREDENTIALS") {
      return _responseFailure(
        e.code,
        "Invalid login credentials. Please make sure email and password are correct",
      );
    }
    return _responseFailure(e.code, e.message);
  }

  Future<AuthenticationResponse> _signUp(
      Map<String, String> credentials) async {
    UserCredential credential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: credentials["email"]!,
      password: credentials["password"]!,
    );
    final userInformation = {
      "email": credentials["email"],
      "firstName": credentials["firstName"],
      "lastName": credentials["lastName"],
    };
    await _userController.createUser(credential.user!.uid, userInformation);
    return _responseSuccess(credential.user!.uid);
  }

  Future<AuthenticationResponse> _signIn(
      Map<String, String> credentials) async {
    UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: credentials["email"]!,
      password: credentials["password"]!,
    );
    return _responseSuccess(credential.user!.uid,
        email: credential.user!.email);
  }
}
