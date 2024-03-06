import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:stars_studios/controllers/user_controller.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stars_studios/models/response.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends ChangeNotifier {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  UserController _userController;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.userId,
    UserController? userController,
  }) : _userController = userController ?? UserController();

  Future<Response> editProfile(Map<String, dynamic> userInfo) async {
    if (_matchesCurrentUserInfo(userInfo)) {
      return Response(success: false, message: "No changes were made");
    }
    final User updatedUser =
        await _userController.updateUser(userId!, userInfo);
    _setUser(updatedUser);
    return Response(success: true, message: "Profile updated");
  }

  bool _matchesCurrentUserInfo(Map<String, dynamic> userInfo) {
    return userInfo["email"] == email &&
        userInfo["firstName"] == firstName &&
        userInfo["lastName"] == lastName;
  }

  void _setUser(User user) {
    userId = user.userId;
    firstName = user.firstName;
    lastName = user.lastName;
    email = user.email;
    notifyListeners();
  }

  //TODO: Change the name of this method. It is vague and doesn't describe what it does.
  Future<void> fromId(String id, {String? email}) async {
    final User user = await _userController.getUser(id);
    if (email != null) {
      if (user.email != email) {
        final updatedUser = await _userController.updateUser(id, {
          "userId": id,
          "email": email,
          "firstName": user.firstName,
          "lastName": user.lastName
        });
        _setUser(updatedUser);
      }
    } else {
      _setUser(user);
    }
  }

  factory User._fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  //TODO: Rename and do something about this method.
  static User fromSomething(Map<String, dynamic> json,
      {UserController? controller}) {
    if (controller == null) {
      return User._fromJson(json);
    } else {
      return User(
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userId: json["userId"],
        userController: controller,
      );
    }
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static User of(BuildContext context) {
    return context.watch<User>();
  }
}
