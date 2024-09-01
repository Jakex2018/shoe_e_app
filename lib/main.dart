import 'package:eco_app/auth/auth_provider.dart';
import 'package:eco_app/firebase_options.dart';
import 'package:eco_app/models/arrival.dart';
import 'package:eco_app/models/brands.dart';
import 'package:eco_app/models/order.dart';

import 'package:eco_app/services/auth_gate.dart';
import 'package:eco_app/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  final firebaseOptions = await getFirebaseOptions(defaultTargetPlatform);
  await Firebase.initializeApp(options: firebaseOptions);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => OrderProvider()),
    ChangeNotifierProvider(create: (context) => ArrivalProvider()),
    ChangeNotifierProvider(create: (context) => CategoryProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthGate(),
        theme: Provider.of<ThemeProvider>(context).light);
  }
}
