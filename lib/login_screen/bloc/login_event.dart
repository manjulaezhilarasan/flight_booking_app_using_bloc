part of "login_bloc.dart";

sealed class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class InitializeLogin extends LoginEvent {}

class OnChangeFormValue extends LoginEvent {
  final Map<String, dynamic> formValues;

  const OnChangeFormValue(this.formValues);

  @override
  List<Object> get props => [formValues];
}

class SubmitLogin extends LoginEvent {}
