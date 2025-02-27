import 'package:equatable/equatable.dart';
import 'package:flight_booking_app_using_bloc/home_screen/models/home_req.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final log = Logger();

  HomeBloc() : super(HomeState.initial) {
    on<InitializeHome>(_onInitializeHome);
    on<OnChangeHomeFormValue>(_onChangeHomeFormValue);
    on<SubmitHome>(_onSubmitHome);
  }

  void _onInitializeHome(
    InitializeHome event,
    Emitter<HomeState> emit,
  ) async {
    try {
      log.d("HomeBloc:: _onInitializeHome:: Event : $event");
      emit(state.copyWith(status: HomeStatus.loading));
      emit(state.copyWith(status: HomeStatus.loaded));
    } catch (error) {
      log.e('HomeBloc::_onInitializeHome:: Error: $error');
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }

  void _onChangeHomeFormValue(
    OnChangeHomeFormValue event,
    Emitter<HomeState> emit,
  ) {
    log.d('HomeBloc :: _onChangeHomeFormValue :: event: ${event.formValues}');
    emit(state.copyWith(status: HomeStatus.changing));
    HomeReqModel homeReqModel = HomeReqModel.fromMap(event.formValues);
    emit(
        state.copyWith(status: HomeStatus.changed, homeReqModel: homeReqModel));
  }

  void _onSubmitHome(
    SubmitHome event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      log.d('HomeBloc::_onSubmitHome:: Event: $event');
      await Future.delayed(Duration(seconds: 1));

      if (state.homeReqModel?.from.isNotEmpty == true &&
          state.homeReqModel?.to.isNotEmpty == true &&
          state.homeReqModel?.departureDate != null) {
        emit(state.copyWith(
            status: HomeStatus.success, message: "Flight Search Succeful"));
      } else {
        emit(state.copyWith(
            status: HomeStatus.failure, message: "Invalid Search parameter"));
      }
    } catch (error) {
      log.e('HomeBloc :: _onSubmitHome :: Error : $error');
      emit(state.copyWith(
        status: HomeStatus.failure,
        message: error.toString(),
      ));
    }
  }
}
