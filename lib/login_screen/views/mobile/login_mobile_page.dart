import 'package:flight_booking_app_using_bloc/login_screen/bloc/login_page_bloc.dart';
import 'package:flight_booking_app_using_bloc/login_screen/bloc/login_page_event.dart';
import 'package:flight_booking_app_using_bloc/login_screen/bloc/login_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'widgets/buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginMobilePage extends StatefulWidget {
  const LoginMobilePage({super.key});

  @override
  State<LoginMobilePage> createState() => _LoginMobilePageState();
}

class _LoginMobilePageState extends State<LoginMobilePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "fly",
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/images/flight.svg",
                      width: 32.0,
                      height: 32.0,
                    ),
                    Text(
                      "t",
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Let's get you Login!",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Enter your information below",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    socialLoginButton("Google", "assets/images/google.svg"),
                    SizedBox(width: 16.0),
                    socialLoginButton("Facebook", "assets/images/facebook.svg"),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.grey.shade300),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("Or Login With"),
                    ),
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.grey.shade300),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'email',
                        decoration: InputDecoration(
                          labelText: "Enter Email",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "Email is required"),
                          FormBuilderValidators.email(
                              errorText: "Enter a valid email"),
                        ]),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      FormBuilderTextField(
                        name: "password",
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                            labelText: "Enter Password",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: Icon(_obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            )),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "Password is required"),
                          FormBuilderValidators.minLength(8,
                              errorText:
                                  "Password must be at least 8 characters")
                        ]),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: Text("Forget Password?",
                        style: TextStyle(
                          color: Color(0xff931158),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                BlocBuilder<LoginPageBloc, LoginPageState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff931158),
                        minimumSize: const Size(double.infinity, 48.0),
                      ),
                      onPressed: state.status == LoginPageStatus.loading
                          ? null
                          : () {
                              if (_formKey.currentState!.saveAndValidate()) {
                                context
                                    .read<LoginPageBloc>()
                                    .add(SubmitLogin());
                              }
                            },
                      child: state.status == LoginPageStatus.loading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                    );
                  },
                ),
                SizedBox(
                  height: 158.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () => context.go('/register'),
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                            color: Color(0xff931158),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
