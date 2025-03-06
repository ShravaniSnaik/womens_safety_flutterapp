import 'package:flutter/material.dart';
import 'package:flutter_demo/child/register_child.dart';
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
  _onSubmit() {
    _formKey.currentState!.save();
    print(_formData['email']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
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
          ),
        ),
      ),
    );
  }
}
