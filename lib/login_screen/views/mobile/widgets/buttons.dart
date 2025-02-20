import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget socialLoginButton(String text, String iconPath) {
  return OutlinedButton.icon(
    onPressed: () {},
    label: Text(text),
    icon: SvgPicture.asset(
      iconPath,
      height: 24.0,
    ),
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      side: BorderSide(color: Colors.grey.shade300),
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
    ),
  );
}
