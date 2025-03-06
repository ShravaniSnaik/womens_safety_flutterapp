import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase_options.dart';
import 'home.dart';

void main () async{
  WidgetsFlutterBinding.ensureInitialized();

try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint(" Firebase Initialized Successfully!");  // ✅ Add this here
  } catch (e) {
    debugPrint(" Firebase Initialization Failed: $e");
}

    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}





