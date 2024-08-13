import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_app/config/InternetException/InternetException.dart'; // Import InternetException widget
import 'Bloc/setUpBloc/set_up_account_bloc.dart';
import 'config/Routes/RoutesInitializing.dart';
import 'config/Routes/Routes_name.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AccountSetupBloc(FirebaseDatabase.instance.ref())),
        // Add other providers here if needed
      ],
      child: MaterialApp(
        title: 'Taxi App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged as Stream<ConnectivityResult>,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data == ConnectivityResult.none) {
                return InternetException(
                  onPress: () {
                    // Implement retry logic here
                  },
                );
              } else {
                return Navigator(
                  onGenerateRoute: Routes.generateRoute,
                  initialRoute: RoutesName.accountSetup,
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
