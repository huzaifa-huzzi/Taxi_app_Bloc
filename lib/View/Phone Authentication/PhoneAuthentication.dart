import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:taxi_app/config/Color/Colors.dart';

class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({super.key});

  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body:  Column(
          children: [
            Container(
              height: height * 0.5 ,
              width: double.infinity,
              decoration:const  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/cty.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child:const  Padding(
                padding: EdgeInsets.symmetric(vertical: 40,horizontal: 20),
                child: Text(
                    'City Cab',
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ),
            ),
            SizedBox(height: height * .03,),
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
                  print(phone.completeNumber);
                },
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.cityBlue,
          onPressed: (){},
           child:  Icon(Icons.arrow_forward,color: AppColor.cityWhite,),
      ),
    );
  }
}
