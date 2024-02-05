class User {
  final String id;
  final String email;

  User({required this.id, required this.email});

  // Future<bool> login(Map<String, String> credentials) async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   return credentials["email"] == email ? true : false;
  //   //await Auth.login(credentials)
  // }

  // Future<bool> logout() async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   return true;
  // }

  // static Future<User> initialize(Map<String, String> credentials,
  //     [Function isEmailTaken = _isEmailTaken]) async {
  //   if (await isEmailTaken(credentials["email"]!) == true) {
  //     throw EmailAlreadyInUseError("Email already in use.");
  //   }
  //   await Future.delayed(const Duration(seconds: 1));
  //   return User(id: "1", email: credentials["email"]!);
  // }

  // static Future<bool> _isEmailTaken(String email) async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   return false;
  // }
}
