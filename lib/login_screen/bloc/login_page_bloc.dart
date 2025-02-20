import 'package:flight_booking_app_using_bloc/login_screen/bloc/login_page_event.dart';
import 'package:flight_booking_app_using_bloc/login_screen/bloc/login_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  final log = Logger();

  LoginPageBloc() : super(LoginPageState()) {
    on<InitializeLogin>(_onInitializeLoginToState);
    on<ChangeEmail>(_onChangeEmail);
    on<ChangePassword>(_onChangePassword);
    on<SubmitLogin>(_onSubmitLogin);
  }

  Future<void> _onInitializeLoginToState(
    InitializeLogin event,
    Emitter<LoginPageState> emit,
  ) async {
    try {
      log.d('LoginPageBloc :: _onInitializeLoginToState :: Event: $event');
      emit(state.copyWith(status: LoginPageStatus.loading));
      emit(state.copyWith(status: LoginPageStatus.loaded));
    } catch (error) {
      log.e('LoginPageBloc::_onInitializeLoginToState::Error: $error');
      emit(state.copyWith(
        status: LoginPageStatus.failure,
        message: error.toString(),
      ));
    }
  }

  void _onChangeEmail(ChangeEmail event, Emitter<LoginPageState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onChangePassword(ChangePassword event, Emitter<LoginPageState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onSubmitLogin(
    SubmitLogin event,
    Emitter<LoginPageState> emit,
  ) async {
    emit(state.copyWith(status: LoginPageStatus.loading));
    try {
      log.d(
          "LoginPageBloc::_onSubmitLogin::email:${state.email}, password:${state.password}");
      await Future.delayed(Duration(seconds: 2));

      if (state.email == "test@example.com" && state.password == "password") {
        emit(state.copyWith(status: LoginPageStatus.success));
      } else {
        emit(state.copyWith(
          status: LoginPageStatus.failure,
          message: "Invalid Email or Password",
        ));
      }
    } catch (error) {
      log.e('LoginPageBloc::_onSubmitLogin::Error: $error');
      emit(state.copyWith(
        status: LoginPageStatus.failure,
        message: error.toString(),
      ));
    }
  }
}
