import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kash_coder_cricket_clans/pages/routes.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../utilis/hexcolors.dart';
import '../utilis/reusablecode.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _repasswordTextController = TextEditingController();
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _phnTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> _addUserDetails(String username, String email, String phone) async {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        final userDocument = FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid);
        await userDocument.set({
          'username': username,
          'email': email,
          'phone no': phone,
        });
      }
    }

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringColor("FFFFFF"),
              hexStringColor("808080"),
              hexStringColor("000000"),
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
              child: Column(children: <Widget>[
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "HELLO THERE",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Register below with your details!",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
                SizedBox(
                  height: 25,
                ),
                reusableTextField("Username", "Enter Usernmae", Icons.person,
                    false, _usernameTextController, (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Username";
                  }
                  return null;
                }),
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
                const SizedBox(height: 25),
                reusableTextField("Phone number", "+91", LineAwesomeIcons.mobile_phone, false, _phnTextController, (value) {
                  if(value!.isEmpty){
                    return "Phone number is required";
                  }
                  return null;
                }),
                const SizedBox(height: 25),
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
                const SizedBox(height: 25),
                reusableTextField(
                    "Confirm Password",
                    "",
                    LineAwesomeIcons.fingerprint,
                    false,
                    _repasswordTextController, (value) {
                  if (value! != _passwordTextController.text) {
                    return "Passwords doesn't match";
                  }
                  return null;
                }),
                reusableButton(context, false, () async {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Center(child: CircularProgressIndicator());
                      },
                    );
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailTextController.text.trim(),
                              password: _passwordTextController.text.trim())
                          .then((value) async {
                        _addUserDetails(
                            _usernameTextController.text.trim(),
                            _emailTextController.text.trim(),
                           _phnTextController.text.trim());
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
                  height: 25,
                ),
                signUpOption(context, false),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future addUserDetails(String username, String email, int phone) async {
    await FirebaseFirestore.instance.collection("users").add({
      'username': username,
      'email': email,
      'phone no': phone,
    });
  }

  bool isValidEmail(String email) {
    return email.contains('@');
  }
}
