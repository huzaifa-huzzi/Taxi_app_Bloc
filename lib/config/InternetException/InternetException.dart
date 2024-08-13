import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/config/Color/Colors.dart';

class InternetException extends StatelessWidget {
  final VoidCallback onPress;

  const InternetException({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final Connectivity connectivity = Connectivity();
    Stream<ConnectivityResult> connectivityStream = connectivity.onConnectivityChanged as Stream<ConnectivityResult>;
    return StreamBuilder<ConnectivityResult>(
      stream: connectivityStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == ConnectivityResult.none) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_off,
                      color: AppColor.cityRed,
                      size: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Center(
                        child: Text(
                          'We are unable to show results.\nPlease check your data\nconnection',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: onPress,
                      child: Text('RETRY'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Show content if connected
            return Container(); // Placeholder; replace with actual content if connected
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
