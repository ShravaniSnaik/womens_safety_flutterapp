import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/child/bottom_page.dart';
import 'package:flutter_demo/child/register_child.dart';
import 'package:flutter_demo/db/sp.dart';
import 'package:flutter_demo/parent/parent_home_screen.dart';
import '../components/custom_textfield.dart'; // Replace with the correct path
import '../components/PrimaryButton.dart';
import '../../utils/constants.dart';
import '../components/SecondaryButton.dart';
import '../parent/parent_register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordShown = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isLoading=false;

  _onSubmit() async{
    _formKey.currentState!.save();
    try {
      setState(() {
        isLoading =true;
      });
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _formData['cemail'].toString(),
    password: _formData['password'].toString(),
  );
  if (userCredential.user!=null){
    // setState(() {
    //     isLoading =true;
    //   });
      FirebaseFirestore.instance
      .collection('users')
      .doc(userCredential.user!.uid)
      .get()
      .then((value) {

         if (!value.exists) {
          dialogueBox(context, "User data not found.");
          setState(() {
            isLoading = false;
          });
          return;
        }

        if(value['type']=='parent'){
          print(value['type']);
          MySharedPreference.saveUserType('parent');
          goTo(context,ParentHomeScreen());
        }
        else
        {
          MySharedPreference.saveUserType('child');
           goTo(context, BottomPage());
        }
        setState(() {
          isLoading = false;
        });
      });
   
  }
} on FirebaseAuthException catch (e) {
  setState(() {
        isLoading =false;
      });
  if (e.code == 'user-not-found') {
    dialogueBox(context,'No user found for that email.' );
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    dialogueBox(context, 'Wrong password provided for that user.');
    print('Wrong password provided for that user.');
  }
}

    print(_formData['email']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
          children:[
            isLoading
                ? progressIndicator(context)
             :
          SingleChildScrollView(
            child:Column(
              children: [
                 Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "USER LOGIN",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      Image.asset('assets/logo.png', height: 100, width: 100),
                    ],
                  ),
                ),

                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextField(
                          hintText: 'Enter email',
                          textInputAction: TextInputAction.next,
                          keyboardtype: TextInputType.emailAddress,
                          prefix: const Icon(Icons.person),
                          onsave: (email) {
                            _formData['email'] = email ?? "";
                          },
                          validate: (email) {
                            if (email!.isEmpty ||
                                email.length < 3 ||
                                !email.contains("@")) {
                              return 'enter correct email';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          hintText: 'Enter password',
                          isPassword: isPasswordShown,
                          prefix: const Icon(Icons.vpn_key_rounded),
                          onsave: (password) {
                            _formData['password'] = password ?? "";
                          },
                          validate: (password) {
                            if (password!.isEmpty || password.length < 7) {
                              return 'enter correct password';
                            }
                            return null;
                          },
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordShown = !isPasswordShown;
                              });
                            },
                            icon:
                                isPasswordShown
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                          ),
                        ),
                        PrimaryButton(
                          title: 'LOGIN',
                          onPressed: () {
                            progressIndicator(context);
                            if (_formKey.currentState!.validate()) {
                              _onSubmit();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Forgot Password", style: TextStyle(fontSize: 18)),
                      SecondaryButton(title: 'click here', onPressed: () {}),
                    ],
                  ),
                ),
                SecondaryButton(
                  title: 'Register as child',
                  onPressed: () {
                    goTo(context, RegisterChildScreen());
                  },
                ),
                SecondaryButton(
                  title: 'Register as parent',
                  onPressed: () {
                    goTo(context, RegisterParentScreen());
                  },
                ),
              ],
            ),
            ],
            ),
          
          ),
          ],
          ),
        ),
      ),
    );
  }
}
