import 'package:flight_booking_app_using_bloc/common/constants.dart';
import 'package:flutter/material.dart';

class UiHelper {
  UiHelper();

  ThemeData themeData(String themeModel) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(0xFF931158),
        brightness: themeModel == Constants.LIGHTMODE ? Brightness.light : Brightness.dark,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          textStyle: WidgetStateProperty.all(
            TextStyle(
              inherit: false,
              fontWeight: FontWeight.w500,
              // fontFamily: Constants.FONT_POPPINS,
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          textStyle: WidgetStateProperty.all(
            TextStyle(
              inherit: false,
              fontWeight: FontWeight.w500,
              // fontFamily: Constants.FONT_POPPINS,
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          inherit: true,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          inherit: true,
          // fontFamily: Constants.FONT_POPPINS,
        ),
        bodyMedium: TextStyle(
          inherit: true,
          // fontFamily: Constants.FONT_POPPINS,
        ),
        bodySmall: TextStyle(
          inherit: true,
          // fontFamily: Constants.FONT_POPPINS,
        ),
        labelLarge: TextStyle(
          inherit: true,
          // fontFamily: Constants.FONT_POPPINS,
        ),
        labelMedium: TextStyle(
          inherit: true,
          // fontFamily: Constants.FONT_POPPINS,
        ),
        labelSmall: TextStyle(
          inherit: true,
          // fontFamily: Constants.FONT_POPPINS,
        ),
        titleLarge: TextStyle(
          inherit: true,
          // fontFamily: Constants.FONT_POPPINS,
        ),
        titleMedium: TextStyle(
          inherit: true,
          // fontFamily: Constants.FONT_POPPINS,
        ),
        titleSmall: TextStyle(
          inherit: true,
          // fontFamily: Constants.FONT_POPPINS,
        ),
        headlineLarge: TextStyle(
          inherit: true,
          // fontFamily: Constants.FONT_POPPINS,
        ),
        headlineMedium: TextStyle(
          inherit: true,
          // fontFamily: Constants.FONT_POPPINS,
        ),
        headlineSmall: TextStyle(
          inherit: true,
          // fontFamily: Constants.FONT_POPPINS,
        ),
        displayLarge: TextStyle(
          inherit: true,
          // fontFamily: Constants.FONT_POPPINS,
        ),
        displayMedium: TextStyle(
          inherit: true,
          // fontFamily: Constants.FONT_POPPINS,
        ),
        displaySmall: TextStyle(
          inherit: true,
          // fontFamily: Constants.FONT_POPPINS,
        ),
      ),
    );
  }
}
