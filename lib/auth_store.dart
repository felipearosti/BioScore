class RegisteredUser {
  const RegisteredUser({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  });

  final String fullName;
  final String email;
  final String phone;
  final String password;
}

class AuthStore {
  AuthStore._();

  static final AuthStore instance = AuthStore._();

  RegisteredUser? _registeredUser;

  bool get hasRegisteredUser => _registeredUser != null;

  void saveUser({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) {
    _registeredUser = RegisteredUser(
      fullName: fullName,
      email: email.trim().toLowerCase(),
      phone: phone,
      password: password,
    );
  }

  bool validateLogin({required String email, required String password}) {
    final user = _registeredUser;
    if (user == null) {
      return false;
    }

    return user.email == email.trim().toLowerCase() && user.password == password;
  }
}
