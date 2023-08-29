import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kash_coder_cricket_clans/pages/routes.dart';

import '../utilis/hexcolors.dart';
import '../utilis/reusablecode.dart';
import 'forgotpass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                hexStringColor("CB2B93"),
                hexStringColor("9546C4"),
                hexStringColor("3E61F3"),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                MediaQuery.of(context).size.height * 0.1,
                20,
                0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    logoWidget("assets/images/logo.png"),
                    SizedBox(height: 25),
                    reusableTextField(
                      "Email",
                      "Enter Email",
                      Icons.email,
                      false,
                      _emailTextController,
                      (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        } else if (!isValidEmail(value)) {
                          return "Invalid email format";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25),
                    reusableTextField(
                      "Password",
                      "Enter Password",
                      Icons.lock,
                      true,
                      _passwordTextController,
                      (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters long";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return ForgotPasswordPage();
                                }),
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    reusableButton(context, true, () async {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(child: CircularProgressIndicator());
                          },
                        );
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text)
                              .then((value) async {
                            await Navigator.pushReplacementNamed(
                                context, MyRoutes.homePage);
                          });
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.message.toString()),
                            ),
                          );
                          //on error pop loding circle
                          Navigator.of(context).pop();
                        }
                      }
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    signUpOption(context, true)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return email.contains('@');
  }
}
