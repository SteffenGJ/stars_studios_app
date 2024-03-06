import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mocks.dart';

void setUpMockResponseForLogInSuccess(
  MockFirebaseAuth mockFirebaseAuth,
  Map<String, String> credentials,
) {
  when(
    mockFirebaseAuth.signInWithEmailAndPassword(
      email: credentials["email"]!,
      password: credentials["password"]!,
    ),
  ).thenAnswer((_) async => MockUserCredential());
}

void setUpMockResponseForLogInFailure(
  MockFirebaseAuth mockFirebaseAuth,
  Map<String, String> credentials,
) {
  when(
    mockFirebaseAuth.signInWithEmailAndPassword(
      email: credentials["email"]!,
      password: credentials["password"]!,
    ),
  ).thenThrow(FirebaseAuthException(code: "wrong-password"));
}

void setUpMockResponseForSignUpSuccess(
  MockFirebaseAuth mockFirebaseAuth,
  Map<String, String> credentials,
) {
  when(
    mockFirebaseAuth.createUserWithEmailAndPassword(
      email: credentials["email"]!,
      password: credentials["password"]!,
    ),
  ).thenAnswer((_) async => MockUserCredential());
}

void setUpMockResponseForSignUpFailure(
  MockFirebaseAuth mockFirebaseAuth,
  Map<String, String> credentials,
) {
  when(
    mockFirebaseAuth.createUserWithEmailAndPassword(
      email: credentials["email"]!,
      password: credentials["password"]!,
    ),
  ).thenThrow(FirebaseAuthException(code: "email-already-in-use"));
}

void setUpMockResponseForLogOut(
  MockFirebaseAuth mockFirebaseAuth,
) {
  when(
    mockFirebaseAuth.signOut(),
  ).thenAnswer((_) async {});
}

Future<SharedPreferences> setUpSharedPrefsWithMockValues(
    [Map<String, Object> values = const {}]) async {
  SharedPreferences.setMockInitialValues(values);
  return await SharedPreferences.getInstance();
}

Future<List<Map<String, Object>>> mockFetchVideos() async {
  return [
    {
      "videoId": "1",
      "title": "title1",
      "description": "description1",
      "url": "url1",
    },
    {
      "videoId": "2",
      "title": "title2",
      "description": "description2",
      "url": "url2",
    },
  ];
}

Future<Map<String, Object>> mockFetchVideo(String id) async {
  return {
    "videoId": "1",
    "title": "title1",
    "description": "description1",
    "url": "url1",
  };
}
