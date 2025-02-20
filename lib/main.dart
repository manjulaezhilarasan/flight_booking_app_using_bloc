import 'package:flight_booking_app_using_bloc/common/constants.dart';
import 'package:flight_booking_app_using_bloc/common/ui_helper.dart';
import 'package:flight_booking_app_using_bloc/login_screen/bloc/login_bloc.dart';
import 'package:flight_booking_app_using_bloc/login_screen/views/mobile/login_mobile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(BlocProvider(
    create: (_) => LoginBloc(),
    child: LoginPage(),
  ));
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    UiHelper uiHelper = UiHelper();
    return MaterialApp.router(
      title: 'Flight Booking App Using BLoc',
      routerConfig: _router,
      theme: uiHelper.themeData(Constants.LIGHTMODE),
    );
  }

  final GoRouter _router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider.value(
        value: context.read<LoginBloc>(),
        child: LoginMobilePage(),
      ),
    ),
  ]);
}
