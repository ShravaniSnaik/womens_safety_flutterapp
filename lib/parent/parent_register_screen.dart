import 'package:flutter/material.dart';
import 'package:flutter_demo/child/child_login_screen.dart';
import '../../utils/constants.dart';
import '../components/SecondaryButton.dart';
import '../components/PrimaryButton.dart';
import '../components/custom_textfield.dart'; // Replace with the correct path

class RegisterParentScreen extends StatefulWidget {
  @override
  State<RegisterParentScreen> createState() => _RegisterParentScreenState();
}

class _RegisterParentScreenState extends State<RegisterParentScreen> {
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        "REGISTER AS PARENT",
                        textAlign: TextAlign.center,
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
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextField(
                          hintText: 'Enter name',
                          textInputAction: TextInputAction.next,
                          keyboardtype: TextInputType.name,
                          prefix: Icon(Icons.person),
                          onsave: (name) {
                            _formData['name'] = name ?? "";
                          },
                          validate: (email) {
                            if (email!.isEmpty || email.length < 3) {
                              return 'enter correct name';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          hintText: 'Enter phone',
                          textInputAction: TextInputAction.next,
                          keyboardtype: TextInputType.phone,
                          prefix: Icon(Icons.phone),
                          onsave: (phone) {
                            _formData['phone'] = phone ?? "";
                          },
                          validate: (email) {
                            if (email!.isEmpty || email.length < 10) {
                              return 'enter correct phone';
                            }
                            return null;
                          },
                        ),
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
                          hintText: 'Enter child email',
                          textInputAction: TextInputAction.next,
                          keyboardtype: TextInputType.emailAddress,
                          prefix: Icon(Icons.person),
                          onsave: (cemail) {
                            _formData['cemail'] = cemail ?? "";
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
                          prefix: Icon(Icons.vpn_key_rounded),
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

                        CustomTextField(
                          hintText: ' retype password',
                          isPassword: isPasswordShown,
                          prefix: Icon(Icons.vpn_key_rounded),
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
                          title: 'REGISTER',
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

                SecondaryButton(
                  title: 'Login with your account',
                  onPressed: () {
                    goTo(context, LoginScreen());
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
