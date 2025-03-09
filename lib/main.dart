import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './child/bottom_page.dart';
import 'package:flutter_demo/child/child_login_screen.dart';
import 'package:flutter_demo/db/sp.dart';
import 'package:flutter_demo/parent/parent_home_screen.dart';
import 'package:flutter_demo/utils/constants.dart';
import './firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint(" Firebase Initialized Successfully!"); // ✅ Add this here
  } catch (e) {
    debugPrint(" Firebase Initialization Failed: $e");
  }

  await MySharedPreference.init();
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
      // home: MySharedPreference.getUserType()=='child'
      // ?HomePage()
      // :MySharedPreference.getUserType()=='parent'
      // ?ParentHomeScreen()
      // :LoginScreen(),
      //we have alternate way for above as it will slow
      home: FutureBuilder(
        future: MySharedPreference.getUserType(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == "") {
            return LoginScreen();
          }
          if (snapshot.data == "child") {
            return BottomPage();
          }
          if (snapshot.data == "parent") {
            return ParentHomeScreen();
          }
          return progressIndicator(context);
        },
      ),
    );
  }
}

// class CheckAuth extends StatelessWidget {
//   // const CheckAuth({super.key});

// checkData(){
//   if(MySharedPreference.getUserType()=='parent'){

//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//     );
//   }
// }
