import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stars_studios/models/user.dart' as user;
import 'package:stars_studios/repositories/user_repository.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  User? get currentUser => MockUser(userId: "userId");

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String? email,
    required String? password,
  }) =>
      super.noSuchMethod(
          Invocation.method(#createUserWithEmailAndPassword, [email, password]),
          returnValue: Future.value(MockUserCredential()));

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String? email,
    required String? password,
  }) =>
      super.noSuchMethod(
          Invocation.method(#signInWithEmailAndPassword, [email, password]),
          returnValue: Future.value(MockUserCredential()));

  @override
  Future<void> signOut() => super.noSuchMethod(Invocation.method(#signOut, []),
      returnValue: Future.value());
}

class MockUser extends Mock implements User {
  final String userId;

  MockUser({required this.userId});

  @override
  String get uid => userId;
}

class MockUserCredential extends Mock implements UserCredential {
  @override
  User get user => MockUser(userId: "userId");
}

class MockUserModel extends Mock implements user.User {
  @override
  Future<void> fromId(String id, {String? email}) async => Future.value();
}

class MockUserRepository extends Mock implements UserRepository {
  @override
  Future<void> create(String id, Map<String, dynamic> credentials) async =>
      Future.value();

  @override
  Future<void> update(String id, Map<String, dynamic> userInfo) async =>
      Future.value();
}

class MockSharedPreferences extends Mock implements SharedPreferences {
  @override
  Future<bool> setString(String key, String value) => Future.value(true);

  @override
  String? getString(String key) => "userId";

  @override
  Future<bool> remove(String key) => Future.value(true);
}
