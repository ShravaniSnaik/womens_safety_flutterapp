import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/child/child_login_screen.dart';
import 'package:flutter_demo/utils/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:TextButton(
          onPressed: ()async{
            try {
              FirebaseAuth.instance.signOut();
              goTo(context, LoginScreen());
            } on FirebaseAuthException catch (e) {
              dialogueBox(context, e.toString());
            }
          },
       child: Text(
        'Sing Out'
        ))) ,
    );
  }
}