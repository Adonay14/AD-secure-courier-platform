class AuthModel {
  final String email;
  final String password;
  bool? loading;
  bool? showPassword;

  AuthModel(
      {required this.email,
      required this.password,
      this.loading = false,
      this.showPassword = true});

  AuthModel copyWith(
      {String? email, String? password, bool? loading, bool? showPassword}) {
    return AuthModel(
      showPassword: showPassword ?? this.showPassword,
      email: email ?? this.email,
      password: password ?? this.password,
      loading: loading ?? this.loading,
    );
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      email: map['email'] as String? ?? '',
      password: map['password'] as String? ?? '',
      loading: map['loading'] as bool? ?? false,
    );
  }

  @override
  String toString() {
    return 'AuthModel(email: $email, password: $password, loading: $loading)';
  }
}
