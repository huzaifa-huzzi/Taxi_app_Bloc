import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({super.key});

  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration:const  BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cty.png'),
                fit: BoxFit.cover,
              ),
            ),
            child:const  Center(
              child: Text(
                'City Cab',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Phone number input field with country flag dropdown
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IntlPhoneField(
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              initialCountryCode: 'US', // Default country code
              onChanged: (PhoneNumber phone) {
                print(phone.completeNumber); // Output the complete number with country code
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                },
                child:const  Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
