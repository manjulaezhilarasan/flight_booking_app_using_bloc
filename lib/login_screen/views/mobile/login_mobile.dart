import 'package:flight_booking_app_using_bloc/login_screen/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'widgets/buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            GoRouter.of(context).go('/home');
          }
          if (state.status == LoginStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.60,
                    child: Column(
                      spacing: 14.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "fly",
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            SvgPicture.asset(
                              "assets/images/flight.svg",
                              width: 32.0,
                              height: 32.0,
                            ),
                            Text(
                              "t",
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        Text(
                          "Let's get you Login!",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Text(
                          "Enter your information below",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            socialLoginButton("Google", "assets/images/google.svg"),
                            SizedBox(width: 16.0),
                            socialLoginButton("Facebook", "assets/images/facebook.svg"),
                          ],
                        ),
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
                        FormBuilder(
                          key: _formKey,
                          onChanged: () {
                            _formKey.currentState?.save();
                            context.read<LoginBloc>().add(OnChangeFormValue(_formKey.currentState!.value));
                          },
                          child: Column(
                            children: [
                              FormBuilderTextField(
                                name: 'email',
                                initialValue: state.loginReqModel?.email,
                                decoration: InputDecoration(
                                  labelText: "Enter Email",
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.email),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(errorText: "Email is required"),
                                  FormBuilderValidators.email(errorText: "Enter a valid email"),
                                ]),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              FormBuilderTextField(
                                name: "password",
                                initialValue: state.loginReqModel?.password,
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
                                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                                    )),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(errorText: "Password is required"),
                                  FormBuilderValidators.minLength(8, errorText: "Password must be at least 8 characters")
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
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff931158),
                            minimumSize: const Size(double.infinity, 48.0),
                          ),
                          onPressed: state.status == LoginStatus.loading
                              ? null
                              : () {
                                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                                    final formData = _formKey.currentState!.value;
                                    context.read<LoginBloc>().add(SubmitLogin(formData));
                                  }
                                },
                          child: state.status == LoginStatus.loading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      SizedBox(
                        width: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).go('/registration');
                        },
                        child: Text(
                          "Register Now",
                          style: TextStyle(color: Color(0xff931158), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
