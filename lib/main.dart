import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_demo/db/sp.dart';
import 'package:flutter_demo/splash.dart';
import 'package:flutter_demo/firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint("Firebase Initialized Successfully!");
  } catch (e) {
    debugPrint("Firebase Initialization Failed: $e");
  }

  await MySharedPreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', primarySwatch: Colors.blue),
      navigatorKey: navigatorKey,
      home: SplashScreen(),
    );
  }
}
