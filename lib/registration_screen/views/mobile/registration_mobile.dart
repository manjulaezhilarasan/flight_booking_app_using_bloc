import 'package:flight_booking_app_using_bloc/registration_screen/bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class RegistrationMobile extends StatefulWidget {
  const RegistrationMobile({super.key});

  @override
  State<RegistrationMobile> createState() => _RegistrationMobileState();
}

class _RegistrationMobileState extends State<RegistrationMobile> {
  final log = Logger();
  final _formKey = GlobalKey<FormBuilderState>();

  final List<String> countries = [
    'India',
    'Bangladesh',
    'Sri Lanka',
    'Pakistan',
    'Singapore',
    'China',
    'Nepal',
    'Bhutan'
  ];

  final Map<String, List<String>> cities = {
    'India': [
      'Chennai',
      'Goa',
      'Bengaluru',
      'Mumbai',
      'Hydrabad',
      'Kochin',
      'Varanasi'
    ],
    'Bangladesh': [
      'Dhaka',
      'Chittagong',
      'Khulna',
      'Sylhet',
      'Rajshahi',
      'Barisal',
      'Rangpur'
    ],
    'Sri Lanka': [
      'Colombo',
      'Kandy',
      'Galle',
      'Jaffna',
      'Negombo',
      'Anuradhapura'
    ],
    'Pakistan': [
      'Karachi',
      'Lahore',
      'Islamabad',
      'Rawalpindi',
      'Faisalabad',
      'Multan',
      'Peshawar'
    ],
    'Singapore': [
      'Orchand',
      ' Tampines',
      'Woodlands',
      'Hougang',
      'Punggol',
      'Jurong'
    ],
    'China': [
      'Beijing',
      'Shanghai',
      'Guangzhou',
      'Shenzhen',
      'Chengdu',
      'Chongqing',
      'Tianjin'
    ],
    'Nepal': [
      'Kathmandu',
      'Pokhara',
      'Lalitpur',
      'Bhaktapur',
      'Biratnagar',
      'Janakpur',
      'Dharan'
    ],
    'Bhutan': [
      'Thimphu',
      'Paro',
      'Punakha',
      'Phuentsholing',
      'Gelephu',
      'Samtse',
      'Mongar'
    ],
  };

  String? selectedCountry = 'India';
  String? selectedCity = 'Chennai';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocConsumer<RegistrationBloc, RegistrationState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state.status == RegistrationStatus.success) {
            log.d("Registration Successful!");
          }
          if (state.status == RegistrationStatus.failure) {
            log.e("Registration Failed: ${state.message}");
          }
        },
        builder: (context, state) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.80,
                      child: Column(
                        spacing: 14.0,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "fly",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
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
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          Text("Register Now!",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  )),
                          Text(
                            "Enter your information below",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                          ),
                          FormBuilder(
                            key: _formKey,
                            onChanged: () {
                              _formKey.currentState?.save();
                              context.read<RegistrationBloc>().add(
                                  OnChangeFormValue(
                                      _formKey.currentState!.value));
                            },
                            child: Column(
                              children: [
                                FormBuilderTextField(
                                  name: "name",
                                  initialValue: state.registrationRegModel.name,
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.minLength(3),
                                    FormBuilderValidators.maxLength(50),
                                  ]),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                FormBuilderTextField(
                                  name: "email address",
                                  initialValue:
                                      state.registrationRegModel.email,
                                  decoration: InputDecoration(
                                    labelText: "Email Address",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.email(),
                                  ]),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                FormBuilderTextField(
                                  name: "mobile number",
                                  initialValue:
                                      state.registrationRegModel.phoneNumber,
                                  decoration: InputDecoration(
                                    labelText: "Mobile Number",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                    FormBuilderValidators.minLength(10),
                                    FormBuilderValidators.maxLength(10),
                                  ]),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                FormBuilderDropdown(
                                  name: 'country',
                                  initialValue: 'India',
                                  decoration: InputDecoration(
                                    labelText: 'Select Country',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: countries
                                      .map((country) => DropdownMenuItem(
                                          value: country, child: Text(country)))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCountry = value;
                                      selectedCity = null;
                                      _formKey.currentState?.fields['city']
                                          ?.reset();
                                    });
                                  },
                                  validator: FormBuilderValidators.required(),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                FormBuilderDropdown(
                                  name: 'city',
                                  initialValue: selectedCity,
                                  decoration: InputDecoration(
                                    labelText: 'Select City',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: (selectedCountry != null &&
                                          cities[selectedCountry] != null)
                                      ? cities[selectedCountry]!
                                          .map(
                                            (city) => DropdownMenuItem(
                                              value: city,
                                              child: Text(city),
                                            ),
                                          )
                                          .toList()
                                      : [],
                                  validator: FormBuilderValidators.required(),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                BlocBuilder<RegistrationBloc,
                                    RegistrationState>(
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        backgroundColor: Color(0xff931158),
                                        minimumSize:
                                            const Size(double.infinity, 48.0),
                                      ),
                                      onPressed: state.status ==
                                              RegistrationStatus.loading
                                          ? null
                                          : () {
                                              if (_formKey.currentState!
                                                  .saveAndValidate()) {
                                                final formData = _formKey
                                                    .currentState!.value;

                                                log.d(
                                                    "Form Submitted: $formData");
                                                context
                                                    .read<RegistrationBloc>()
                                                    .add(SubmitRegistration(
                                                        formData));
                                              } else {
                                                log.e(
                                                    "Form validation failed! Please fill all fields correctly.");
                                              }
                                            },
                                      child: state.status ==
                                              RegistrationStatus.loading
                                          ? CircularProgressIndicator(
                                              color: Color(0xff931158),
                                            )
                                          : Text(
                                              "Register",
                                              style: TextTheme.of(context)
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: Colors.white,
                                                  ),
                                            ),
                                    );
                                  },
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Already a Member?"),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          GoRouter.of(context).go('/');
                                        },
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Color(0xff931158),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
