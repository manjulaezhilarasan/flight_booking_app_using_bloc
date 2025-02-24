part of 'registration_bloc.dart';

enum RegistrationStatus {
  initial,
  changing,
  changed,
  loading,
  loaded,
  success,
  failure
}

class RegistrationState extends Equatable {
  final RegistrationStatus status;
  final String message;
  final RegistrationRegModel registrationRegModel;

  const RegistrationState({
    this.status = RegistrationStatus.initial,
    this.message = "",
    required this.registrationRegModel,
  });

  static final initial = RegistrationState(
    status: RegistrationStatus.initial,
    message: "",
    registrationRegModel: RegistrationRegModel.getInstance(),
  );

  RegistrationState copyWith({
    RegistrationStatus? status,
    String? message,
    RegistrationRegModel? registrationReqModel,
  }) {
    return RegistrationState(
      status: status ?? this.status,
      message: message ?? this.message,
      registrationRegModel: registrationReqModel ?? registrationRegModel,
    );
  }

  @override
  List<Object> get props => [status, message, registrationRegModel];
}
