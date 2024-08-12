

class RoutesName {

  static const String splashScreen = 'SplashScreen';


  //Authentication
  static const String phoneAuthentication = 'PhoneAuthentication';
  static const String otpVerification = 'OtpVerificationScreen';

  //Screens in app
  static const String homeScreen = 'HomeScreen';
  static const String accountSetup = 'SetUpAccount';
  static const String googleMap = 'GoogleMaps';

}

class OtpVerificationArguments {
  final String phoneNumber;
  final String verificationId;

  OtpVerificationArguments(this.phoneNumber, this.verificationId);
}
