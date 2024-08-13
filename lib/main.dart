import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/setUpBloc/set_up_account_bloc.dart';
import 'config/Components/InternetConnectivity.dart';
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
        BlocProvider(create: (_) => AccountSetupBloc(FirebaseDatabase.instance.reference())),
        // Add other providers here if needed
      ],
      child: ConnectivityListener(
        child: MaterialApp(
          title: 'Taxi App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: RoutesName.accountSetup,
          onGenerateRoute: Routes.generateRoute,
        ),
      ),
    );
  }
}
