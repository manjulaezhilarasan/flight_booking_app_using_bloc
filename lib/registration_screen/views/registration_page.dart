import 'package:flight_booking_app_using_bloc/registration_screen/bloc/registration_bloc.dart';
import 'package:flight_booking_app_using_bloc/registration_screen/views/mobile/registration_mobile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: RegistrationMobile(),
    );
  }
}
