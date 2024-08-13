import 'package:flutter/material.dart';

import '../../Services/Connectivity/ConnectivityServices.dart';

class ConnectivityListener extends StatelessWidget {
  final Widget child;

  const ConnectivityListener({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connectivityService = ConnectivityService();

    return StreamBuilder<bool>(
      stream: connectivityService.connectivityStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          final isConnected = snapshot.data!;
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
                      onPressed: () {
                        connectivityService.checkConnectivity();
                      },
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              ),
            );
          }
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }
}
