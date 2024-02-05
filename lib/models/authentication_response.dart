class AuthenticationResponse {
  final bool success;
  final Map<String, String?>? data;
  final Map<String, String?>? error;
  final String? errorMessage;
  final String? errorCode;
  final String? userId;

  AuthenticationResponse({
    required this.success,
    required this.data,
    required this.error,
  })  : errorMessage = error?["message"],
        errorCode = error?["code"],
        userId = data?["userId"];
}
