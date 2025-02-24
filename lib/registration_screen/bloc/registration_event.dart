part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class InitializeRegistration extends RegistrationEvent {}

class OnChangeFormValue extends RegistrationEvent {
  final Map<String, dynamic> formValues;
  const OnChangeFormValue(this.formValues);

  @override
  List<Object> get props => [formValues];
}

class SubmitRegistration extends RegistrationEvent {
  final Map<String, dynamic> formValues;
  const SubmitRegistration(this.formValues);

  @override
  List<Object> get props => [formValues];
}
