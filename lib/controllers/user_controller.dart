import 'package:stars_studios/models/user.dart';
import 'package:stars_studios/repositories/user_repository.dart';

class UserController {
  final UserRepository _userRepository;

  UserController({UserRepository? userRepository})
      : _userRepository = userRepository ?? UserRepository();

  Future<User> getUser(String id) async {
    final json = await _userRepository.fetch(id);
    return User.fromJson(json);
  }

  Future<User> updateUser(String id, Map<String, dynamic> userInfo) async {
    await _userRepository.update(id, userInfo);
    return User.fromJson(userInfo, controller: this);
  }

  Future<void> createUser(String id, Map<String, dynamic> userInfo) async {
    final userInformation = {...userInfo, "userId": id};
    await _userRepository.create(id, userInformation);
  }
}
