import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:taxi_app/Bloc/PhoneAuthentication/phone_auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/config/Routes/Routes_name.dart';

class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({super.key});

  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  late PhoneAuthenticationBloc _phoneAuthBloc;
  String _phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _phoneAuthBloc = PhoneAuthenticationBloc();
  }

  @override
  void dispose() {
    _phoneAuthBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => _phoneAuthBloc,
        child: BlocListener<PhoneAuthenticationBloc, PhoneAuthState>(
          listener: (context, state) {
            if (state is PhoneAuthCodeSent) {
              Navigator.pushNamed(
                context,
                RoutesName.otpVerification,
                arguments: {
                  'phoneNumber': _phoneNumber,
                  'verificationId': state.verificationId,
                },
              );
            } else if (state is PhoneAuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is PhoneAuthVerified) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Phone number verified successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          child: BlocBuilder<PhoneAuthenticationBloc, PhoneAuthState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/cty.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'City Cab',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IntlPhoneField(
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'US',
                      onChanged: (phone) {
                        _phoneNumber = phone.completeNumber;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_phoneNumber.isNotEmpty) {
                            _phoneAuthBloc.add(
                              PhoneAuthNumberSubmitted(phoneNumber: _phoneNumber),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                             const  SnackBar(
                                content: Text('Please enter a phone number'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          }
                        },
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
