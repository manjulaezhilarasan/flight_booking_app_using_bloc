import 'package:flight_booking_app_using_bloc/home_screen/bloc/home_bloc.dart';
import 'package:flight_booking_app_using_bloc/home_screen/views/mobile/home_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: HomeMobile(),
    );
  }
}
