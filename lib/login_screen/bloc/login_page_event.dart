import 'package:equatable/equatable.dart';

sealed class LoginPageEvent extends Equatable {
  const LoginPageEvent();
  @override
  List<Object> get props => [];
}

class InitializeLogin extends LoginPageEvent {}

class ChangeEmail extends LoginPageEvent {
  final String email;

  const ChangeEmail(this.email);

  @override
  List<Object> get props => [email];
}

class ChangePassword extends LoginPageEvent {
  final String password;

  const ChangePassword(this.password);

  @override
  List<Object> get props => [password];
}

class SubmitLogin extends LoginPageEvent {}
