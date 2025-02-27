part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class InitializeHome extends HomeEvent {}

class OnChangeHomeFormValue extends HomeEvent {
  final Map<String, dynamic> formValues;
  const OnChangeHomeFormValue(this.formValues);

  @override
  List<Object> get props => [formValues];
}

class SubmitHome extends HomeEvent {
  final Map<String, dynamic> formValues;
  const SubmitHome(this.formValues);

  @override
  List<Object> get props => [formValues];
}
