import 'package:flight_booking_app_using_bloc/login_screen/bloc/login_bloc.dart';
import 'package:flight_booking_app_using_bloc/login_screen/views/mobile/login_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: LoginMobile(),
    );
  }
}
