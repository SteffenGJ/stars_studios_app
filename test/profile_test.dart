import 'package:stars_studios/controllers/user_controller.dart';
import 'package:stars_studios/models/user.dart';
import 'package:test/test.dart';

import 'mocks/mocks.dart';

void main() {
  late User user;
  late MockUserRepository mockUserRepository;

  setUp(() async {
    mockUserRepository = MockUserRepository();
    user = User(
      userId: "1234",
      email: "email",
      firstName: "First",
      lastName: "Last",
      userController: UserController(userRepository: mockUserRepository),
    );
  });

  group("Profile", () {
    test("should edit user information", () async {
      final Map<String, dynamic> updatedUserInfo = {
        "userId": "1234",
        "email": "email",
        "firstName": "NewFirst",
        "lastName": "Last",
      };

      final response = await user.editProfile(updatedUserInfo);

      expect(response.success, true);
    });

    test(
        "should not edit user information if provided information is the same as the current",
        () async {
      final Map<String, dynamic> sameUserInfo = {
        "userId": "1234",
        "email": "email",
        "firstName": "First",
        "lastName": "Last",
      };

      final response = await user.editProfile(sameUserInfo);

      expect(response.success, false);
    });
  });
}
