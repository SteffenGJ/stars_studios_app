import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stars_studios/models/user.dart' as user;
import 'package:stars_studios/repositories/notification_repository.dart';
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
  Future<void> setFromId(String id, {String? email}) async => Future.value();
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

// class MockNotificationRepository extends Mock implements NotificationRepository {
//   //Future<List<Map<String, dynamic>>> fetchNotifications(User user) async {
//   @override
//   Future<List<Map<String, dynamic>>> fetchNotifications(User user) async {
//      return Future.value([{"title": "title", }]);
//   }
// }

class MockNotificationRepository extends Mock
    implements NotificationRepository {
  @override
  Future<List<Map<String, dynamic>>> fetchNotifications(user.User user) async {
    final dateOne = DateTime(2024, 3, 6, 7, 58, 0);
    final dateTwo = DateTime(2024, 3, 6, 7, 59, 0);
    return Future.value([
      {
        "title": "title",
        "text": "text",
        "createdAt": Timestamp.fromDate(dateOne),
        "id": "id"
      },
      {
        "title": "title",
        "text": "text",
        "createdAt": Timestamp.fromDate(dateTwo),
        "id": "id"
      }
    ]);
  }
}
