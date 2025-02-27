import 'package:flight_booking_app_using_bloc/common/constants.dart';
import 'package:flight_booking_app_using_bloc/common/ui_helper.dart';
import 'package:flight_booking_app_using_bloc/home_screen/views/home_page.dart';
import 'package:flight_booking_app_using_bloc/login_screen/bloc/login_bloc.dart';
import 'package:flight_booking_app_using_bloc/login_screen/views/login_page.dart';
import 'package:flight_booking_app_using_bloc/registration_screen/views/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => LoginBloc(),
      ),
    ],
    child: FlightBookingApp(),
  ));
}

class FlightBookingApp extends StatelessWidget {
  FlightBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flight Booking App Using BLoc',
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: UiHelper().themeData(Constants.LIGHTMODE),
    );
  }

  final GoRouter _router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/registration',
      builder: (context, state) => RegistrationPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
  ]);
}
