import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flight_booking_app_using_bloc/registration_screen/models/registration_req.dart';
import 'package:logger/logger.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final log = Logger();
  RegistrationBloc() : super(RegistrationState.initial) {
    on<InitializeRegistration>(_onInitializeRegistrationToState);
    on<OnChangeFormValue>(_onChangeFormValue);
    on<SubmitRegistration>(_onSubmitRegistration);
  }

  Future<void> _onInitializeRegistrationToState(
    InitializeRegistration event,
    Emitter<RegistrationState> emit,
  ) async {
    try {
      log.d(
          'RegistrationBloc :: _onInitializeRegistrationToState :: Event: $event');
      emit(state.copyWith(status: RegistrationStatus.loading));
      emit(state.copyWith(status: RegistrationStatus.loaded));
    } catch (error) {
      log.e(
          'RegistrationBloc :: _onInitializeRegistrationToState :: Error: $error');
      emit(state.copyWith(
        status: RegistrationStatus.failure,
        message: error.toString(),
      ));
    }
  }

  void _onChangeFormValue(
    OnChangeFormValue event,
    Emitter<RegistrationState> emit,
  ) {
    log.d(
        "RegistrationBloc :: _onChangeFormValue :: formValues : ${event.formValues}");
    emit(state.copyWith(status: RegistrationStatus.changing));
    RegistrationRegModel registrationRegModel =
        state.registrationRegModel.copyWith(
      name: event.formValues['name'] ?? state.registrationRegModel.name,
      email: event.formValues['email'] ?? state.registrationRegModel.email,
      phoneNumber: event.formValues['phoneNumber'] ??
          state.registrationRegModel.phoneNumber,
      country:
          event.formValues['country'] ?? state.registrationRegModel.country,
      city: event.formValues['city'] ?? state.registrationRegModel.city,
    );
    emit(state.copyWith(
        status: RegistrationStatus.changed,
        registrationReqModel: registrationRegModel));
  }

  void _onSubmitRegistration(
    SubmitRegistration event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(status: RegistrationStatus.loading));
    try {
      log.d("RegistrationBloc :: _onSubmitRegistration :: $event");
      await Future.delayed(Duration(seconds: 1));
      emit(state.copyWith(
          status: RegistrationStatus.success,
          message: "Registration Successful."));
    } catch (error) {
      log.e("RegistrationBloc :: _onSubmitRegistration :: Error : $error");
      emit(state.copyWith(
        status: RegistrationStatus.failure,
        message: error.toString(),
      ));
    }
  }
}
