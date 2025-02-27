import 'package:flight_booking_app_using_bloc/home_screen/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  final log = Logger();
  final _formKey = GlobalKey<FormBuilderState>();

  String tripType = "One Way";

  final List<String> locations = [
    'Dubai',
    'United Arab Emirates',
    'Aukland',
    'New Zealand',
    'Chennai',
    'Mumbai',
    'Delhi',
    'Bengaluru',
    'Hyderabad',
    'Kolkata',
    'Goa'
  ];

  final List<String> travelClasses = ['Economy', 'Business', 'First Class'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Hello Tim 👋 ",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_active_outlined,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            )
          ],
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
            if (state.status == HomeStatus.success) {
              log.d("Search Flight Successful");
            }
            if (state.status == HomeStatus.failure) {
              log.e("Search Flight Failed: ${state.message}");
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Container(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height * 0.4,
                    color: Theme.of(context).colorScheme.primary,
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      "Find your flights",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 330.0,
                    height: MediaQuery.of(context).size.height * 0.60,
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSecondary,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.outline,
                            blurRadius: 8.0,
                            spreadRadius: 2.0,
                          )
                        ],
                      ),
                      child: FormBuilder(
                        key: _formKey,
                        onChanged: () {
                          _formKey.currentState?.save();
                          context.read<HomeBloc>().add(OnChangeHomeFormValue(_formKey.currentState!.value));
                        },
                        child: Column(
                          spacing: 16.0,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FlightTypeButton(
                                  icon: Icons.arrow_forward,
                                  text: "One Way",
                                  selected: true,
                                ),
                                FlightTypeButton(icon: Icons.autorenew, text: "Round Trip"),
                                FlightTypeButton(icon: Icons.arrow_upward, text: "Multi City"),
                              ],
                            ),
                            FormBuilderDropdown(
                              name: 'from',
                              decoration: InputDecoration(
                                labelText: 'From',
                                border: OutlineInputBorder(),
                              ),
                              validator: FormBuilderValidators.required(),
                              items: locations.map((location) => DropdownMenuItem(value: location, child: Text(location))).toList(),
                            ),
                            FormBuilderDropdown(
                              name: 'to',
                              decoration: InputDecoration(
                                labelText: 'To',
                                border: OutlineInputBorder(),
                              ),
                              items: locations.map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
                              validator: FormBuilderValidators.required(),
                            ),
                            FormBuilderDateTimePicker(
                              name: 'departureDate',
                              inputType: InputType.date,
                              decoration: InputDecoration(
                                labelText: 'Departure Date',
                                border: OutlineInputBorder(),
                              ),
                              validator: FormBuilderValidators.required(),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: FormBuilderDropdown(
                                    name: 'passengers',
                                    decoration: InputDecoration(
                                      labelText: 'Passengers',
                                      border: OutlineInputBorder(),
                                    ),
                                    items: List.generate(10, (index) => index + 1)
                                        .map(
                                          (number) => DropdownMenuItem(
                                            value: number,
                                            child: Text(
                                              number.toString(),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    validator: FormBuilderValidators.required(),
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: FormBuilderDropdown(
                                    name: 'travelClass',
                                    decoration: InputDecoration(
                                      labelText: "Travel Class",
                                      border: OutlineInputBorder(),
                                    ),
                                    items: travelClasses
                                        .map(
                                          (tClass) => DropdownMenuItem(
                                            value: tClass,
                                            child: Text(tClass),
                                          ),
                                        )
                                        .toList(),
                                    validator: FormBuilderValidators.required(),
                                  ),
                                ),
                              ],
                            ),
                            BlocConsumer<HomeBloc, HomeState>(
                              listener: (context, state) {
                                if (state.status == HomeStatus.success) {
                                  GoRouter.of(context).go('/');
                                } else if (state.status == HomeStatus.failure) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No flights found. Please try again.")));
                                }
                              },
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: state.status == HomeStatus.loading
                                      ? null
                                      : () {
                                          if (_formKey.currentState?.saveAndValidate() ?? false) {
                                            final formData = _formKey.currentState!.value;
                                            context.read<HomeBloc>().add(SubmitHome(formData));
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff931158),
                                    minimumSize: const Size(double.infinity, 48.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: state.status == HomeStatus.loading
                                      ? CircularProgressIndicator(
                                          color: Theme.of(context).colorScheme.onSecondary,
                                        )
                                      : Text(
                                          "Search Flights",
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context).colorScheme.onSecondary,
                                              ),
                                        ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class FlightTypeButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool selected;
  const FlightTypeButton({super.key, required this.text, required this.icon, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
          color: selected ? Color(0xff931158) : Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Theme.of(context).colorScheme.outline)),
      child: Row(
        children: [
          Icon(
            icon,
            size: 10.0,
            color: selected ? Theme.of(context).colorScheme.onSecondary : Colors.black,
          ),
          SizedBox(
            width: 3.0,
          ),
          Text(
            text,
            style: TextStyle(color: selected ? Theme.of(context).colorScheme.onSecondary : Colors.black),
          ),
        ],
      ),
    );
  }
}
