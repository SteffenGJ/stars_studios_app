class PasswordsDoNotMatchException implements Exception {
  final String message;

  PasswordsDoNotMatchException(this.message);

  @override
  String toString() {
    return 'PasswordsDoNotMatchException: $message';
  }
}
