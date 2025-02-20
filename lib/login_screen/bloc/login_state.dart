part of "login_bloc.dart";

enum LoginStatus { initial, changing, changed, loading, loaded, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String message;
  final LoginReqModel? loginReqModel;

  const LoginState({
    this.status = LoginStatus.initial,
    required this.message,
    this.loginReqModel,
  });

  static const initial = LoginState(
    status: LoginStatus.initial,
    message: "",
  );

  LoginState copyWith({
    LoginStatus? status,
    String? message,
    LoginReqModel? loginReqModel,
  }) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
      loginReqModel: loginReqModel ?? this.loginReqModel,
    );
  }

  @override
  List<Object?> get props => [status, message, loginReqModel];
}
