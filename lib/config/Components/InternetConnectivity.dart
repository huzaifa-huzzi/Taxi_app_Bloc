import 'package:flutter/material.dart';
import 'package:taxi_app/config/Color/Colors.dart';

import '../../Services/Connectivity/ConnectivityServices.dart';

class ConnectivityCheckWidget extends StatelessWidget {
  final Widget child;

  const ConnectivityCheckWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConnectivityService connectivityService = ConnectivityService();

    return FutureBuilder<bool>(
      future: connectivityService.isConnected(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  Center(child: CircularProgressIndicator(color:AppColor.cityBlue ,));
        }

        if (snapshot.hasData) {
          final bool isConnected = snapshot.data!;
          if (isConnected) {
            return child;
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'No Internet Connection',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final bool connected = await connectivityService.isConnected();
                        if (connected) {
                          // Rebuild the widget if reconnected
                          (context as Element).markNeedsBuild();
                        }
                      },
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              ),
            );
          }
        } else {
          return const Center(child: Text('Error checking connectivity'));
        }
      },
    );
  }
}
