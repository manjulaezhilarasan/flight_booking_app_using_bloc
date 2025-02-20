import 'package:equatable/equatable.dart';

enum LoginPageStatus { initial, loading, loaded, success, failure }

class LoginPageState extends Equatable {
  final String email;
  final String password;
  final LoginPageStatus status;
  final String message;

  const LoginPageState({
    this.email = '',
    this.password = '',
    this.status = LoginPageStatus.initial,
    this.message = '',
  });

  LoginPageState copyWith(
      {String? email,
      String? password,
      LoginPageStatus? status,
      String? message}) {
    return LoginPageState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [email, password, status, message];
}
