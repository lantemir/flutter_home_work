import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, error }

class LoginState extends Equatable {
  final String email;
  final String password;

  final bool emailValid;
  final bool passwordValid;

  final LoginStatus status;
  final String? errorMessage;

  const LoginState({
    required this.email,
    required this.password,
    required this.emailValid,
    required this.passwordValid,
    required this.status,
    required this.errorMessage,
  });

  factory LoginState.initial() => const LoginState(
    email: '',
    password: '',
    emailValid: true,
    passwordValid: true,
    status: LoginStatus.initial,
    errorMessage: null,
  );

  bool get canSubmit =>
      email.isNotEmpty && password.isNotEmpty && emailValid && passwordValid;

  LoginState copyWith({
    String? email,
    String? password,
    bool? emailValid,
    bool? passwordValid,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailValid: emailValid ?? this.emailValid,
      passwordValid: passwordValid ?? this.passwordValid,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    emailValid,
    passwordValid,
    status,
    errorMessage,
  ];
}
