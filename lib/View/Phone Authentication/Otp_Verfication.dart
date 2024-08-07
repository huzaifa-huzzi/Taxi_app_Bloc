import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taxi_app/Bloc/PhoneAuthentication/phone_auth_bloc.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const OtpVerificationScreen({
    required this.phoneNumber,
    required this.verificationId,
    Key? key,
  }) : super(key: key);

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late PhoneAuthenticationBloc _phoneAuthBloc;
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
      appBar: AppBar(title: const Text('Enter Code')),
      body: BlocProvider(
        create: (context) => _phoneAuthBloc,
        child: BlocListener<PhoneAuthenticationBloc, PhoneAuthState>(
          listener: (context, state) {
            if (state is PhoneAuthVerified) {
              Navigator.pushNamed(context, '/nextScreen');
            } else if (state is PhoneAuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'A 6-digit code has been sent to ${widget.phoneNumber}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 20.0),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  onChanged: (value) {
                    _smsCode = value;
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _phoneAuthBloc.add(
                      PhoneAuthCodeSubmitted(
                        verificationId: widget.verificationId,
                        smsCode: _smsCode,
                      ),
                    );
                  },
                  child: const Text('Verify Code'),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Resend code in 59s',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _phoneAuthBloc.add(
                      PhoneAuthNumberSubmitted(phoneNumber: widget.phoneNumber),
                    );
                  },
                  child: const Text('Send Code Again'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
