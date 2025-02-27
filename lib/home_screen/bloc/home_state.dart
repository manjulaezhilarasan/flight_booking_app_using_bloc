part of 'home_bloc.dart';

enum HomeStatus {
  initial,
  changing,
  changed,
  loading,
  loaded,
  success,
  failure
}

class HomeState extends Equatable {
  final HomeStatus status;
  final String message;
  final HomeReqModel? homeReqModel;

  const HomeState({
    this.status = HomeStatus.initial,
    required this.message,
    this.homeReqModel,
  });

  static const initial = HomeState(
    status: HomeStatus.initial,
    message: "",
  );

  HomeState copyWith({
    HomeStatus? status,
    String? message,
    HomeReqModel? homeReqModel,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      homeReqModel: homeReqModel ?? this.homeReqModel,
    );
  }

  @override
  List<Object?> get props => [status, message, homeReqModel];
}
