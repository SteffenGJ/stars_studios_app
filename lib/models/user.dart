import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<String>? readNotifications;
  DateTime? createdAt;
  UserController _userController;

  //PLAN ANGÅENDE NOTIFIKATIONER:
  //Useren gemmer en liste af de notifikationsid'er, som brugeren har læst.
  //Når Notificationsene bliver loadet, kan man matche listen af notifikationer med listen af de gemte id'er.
  //På den måde er notifikationer og usere ikke direkte forbundet, men der er alligevel et link.

  //Mon useren kun skal modtage notifications fra efter den er blevet oprettet? Der er jo ingen grund til at modtage old news.
  //Måske en user.loadNotifications() method?

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.userId,
    this.createdAt,
    this.readNotifications,
    UserController? userController,
  }) : _userController = userController ?? UserController();

  bool hasRead(String id) {
    return readNotifications?.contains(id) ?? false;
  }

  Future<void> readNotification(String id) async {
    readNotifications!.add(id);
    final updatedUser = await _userController.updateUser(userId!, toJson());
    _setUser(updatedUser);
  }

  Future<Response> editProfile(Map<String, dynamic> userInfo) async {
    if (_matchesCurrentUserInfo(userInfo)) {
      return Response(success: false, message: "No changes were made");
    }
    final User updatedUser =
        await _userController.updateUser(userId!, userInfo);
    _setUser(updatedUser);
    return Response(success: true, message: "Profile updated");
  }

  Future<void> setFromId(String id, {String? email}) async {
    final User user = await _userController.getUser(id);
    await _determineSetUser(id, user, email: email);
  }

  Future<void> _determineSetUser(String id, User user, {String? email}) async {
    if (email != null) {
      await _updateEmail(id, user, email: email);
    } else {
      _setUser(user);
    }
  }

  Future<void> _updateEmail(String id, User user, {String? email}) async {
    if (user.email != email) {
      final updatedUser = await _userController.updateUser(id, {
        "userId": id,
        "email": email,
        "firstName": user.firstName,
        "lastName": user.lastName
      });
      _setUser(updatedUser);
    }
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
    readNotifications = user.readNotifications;
    createdAt = user.createdAt;
    notifyListeners();
  }

  static User fromJson(Map<String, dynamic> json,
      {UserController? controller}) {
    // if (controller == null) {
    //   return User._fromJson(json);
    // } else {
    return User(
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      userId: json["userId"],
      readNotifications: (json['readNotifications'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json["createdAt"].toDate(),
      userController: controller,
    );
    //}
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "readNotifications": readNotifications,
      "createdAt": Timestamp.fromDate(createdAt!),
    };
  }

  factory User._fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> _toJson() => _$UserToJson(this);

  static User of(BuildContext context) {
    return context.watch<User>();
  }
}
