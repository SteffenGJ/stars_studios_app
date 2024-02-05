import 'package:stars_studios/models/authentication_response.dart';
import 'package:stars_studios/shared/firebase_authentication.dart';
import 'package:test/test.dart';
import 'mocks/mock_setup_functions.dart';
import 'mocks/mocks.dart';

void main() {
  late FirebaseAuthentication authenticator;
  late MockFirebaseAuth mockFirebaseAuth;
  final credentials = {"email": "test@email.com", "password": "test"};

  setUp(() async {
    mockFirebaseAuth = MockFirebaseAuth();
    authenticator = FirebaseAuthentication(instance: mockFirebaseAuth);
  });

  group("Authentication", () {
    test("should log in user given correct credentials", () async {
      // Custom function for setting up this particular mock. Defined in mocks/mock_setup_functions.dart.
      setUpMockResponseForLogInSuccess(mockFirebaseAuth, credentials);

      final AuthenticationResponse response =
          await authenticator.login(credentials);
      expect(response.success, true);
    });

    test("should not log in user given incorrect credentials", () async {
      // Custom function for setting up this particular mock. Defined in mocks/mock_setup_functions.dart.
      setUpMockResponseForLogInFailure(mockFirebaseAuth, credentials);

      final AuthenticationResponse response =
          await authenticator.login(credentials);

      expect(response.errorCode, "wrong-password");
    });

    test("should sign up user given valid credentials", () async {
      // Custom function for setting up this particular mock. Defined in mocks/mock_setup_functions.dart.
      setUpMockResponseForSignUpSuccess(mockFirebaseAuth, credentials);

      final AuthenticationResponse response =
          await authenticator.createUser(credentials);

      expect(response.success, true);
    });

    test("should not sign up user if account is already activated", () async {
      // Custom function for setting up this particular mock. Defined in mocks/mock_setup_functions.dart.
      setUpMockResponseForSignUpFailure(mockFirebaseAuth, credentials);

      await authenticator.createUser(credentials);
      //Create  another user with the same credentials
      final AuthenticationResponse response =
          await authenticator.createUser(credentials);

      expect(response.errorCode, "email-already-in-use");
    });

    test("should be able to log out a user", () async {
      // Custom function for setting up this particular mock. Defined in mocks/mock_setup_functions.dart.
      setUpMockResponseForLogOut(mockFirebaseAuth);

      final AuthenticationResponse response = await authenticator.logout();

      expect(response.success, true);
    });
  });
}
