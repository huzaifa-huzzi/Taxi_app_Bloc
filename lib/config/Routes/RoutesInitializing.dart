
import 'package:flutter/material.dart';
import 'package:taxi_app/View/Home/homeScreen.dart';
import 'package:taxi_app/View/Maps/GoogleMaps.dart';
import 'package:taxi_app/View/Phone%20Authentication/Otp_Verfication.dart';
import 'package:taxi_app/View/Phone%20Authentication/PhoneAuthentication.dart';
import 'package:taxi_app/View/SetUp%20Account/SetupAccount.dart';
import 'package:taxi_app/View/Splash/SplashScreen.dart';
import 'package:taxi_app/config/InternetException/InternetException.dart';
import 'package:taxi_app/config/Routes/Routes_name.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){

      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) =>const  SplashScreen());

      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) =>const  HomeScreen());

      case RoutesName.phoneAuthentication:
        return MaterialPageRoute(builder: (context) =>const  PhoneAuthentication());

      case RoutesName.otpVerification:
        final args = settings.arguments as OtpVerificationArguments;
        return MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(
            phoneNumber: args.phoneNumber,
            verificationId: args.verificationId,
          ),
        );

      case RoutesName.accountSetup:
        return MaterialPageRoute(builder: (context) =>const  SetUpAccount());

      case RoutesName.googleMap:
        return MaterialPageRoute(builder: (context) =>const GoogleMaps() );


      default :
        return MaterialPageRoute(builder: (context){
          return const Scaffold(
            body: Center(
              child: Text('No Page Generate'),
            ),
          );
        });
    }


  }

}
