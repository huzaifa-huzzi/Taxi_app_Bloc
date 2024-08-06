import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:taxi_app/Bloc/PhoneAuthentication/phone_auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({super.key});

  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  late PhoneAuthenticationBloc _phoneAuthBloc;
  String _phoneNumber = '';
  String _verificationId = '';
  String _smsCode = '';

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
      body: BlocProvider(
        create: (context) => _phoneAuthBloc,
        child: BlocListener<PhoneAuthenticationBloc, PhoneAuthState>(
          listener: (context, state) {
            if (state is PhoneAuthCodeSent) {
              _verificationId = state.verificationId;
              _showSmsCodeDialog();
            } else if (state is PhoneAuthVerified) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Phone number verified')));
            } else if (state is PhoneAuthError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<PhoneAuthenticationBloc, PhoneAuthState>(
            builder: (context, state) {
              if (state is PhoneAuthLoading) {
                return const  Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  // Header image with a background
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration:const  BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/cty.png'), // Ensure this path is correct
                        fit: BoxFit.cover,
                      ),
                    ),
                    child:const  Center(
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
                      decoration:const  InputDecoration(
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
                          _phoneAuthBloc.add(PhoneAuthNumberSubmitted(_phoneNumber));
                        },
                        child:const  Icon(Icons.arrow_forward),
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

  void _showSmsCodeDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title:const  Text('Enter SMS Code'),
          content: TextField(
            onChanged: (value) {
              _smsCode = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _phoneAuthBloc.add(PhoneAuthCodeSubmitted(_verificationId, _smsCode));
              },
              child:const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
