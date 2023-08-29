import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kash_coder_cricket_clans/utilis/reusablecode.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

final _emailController = TextEditingController();

@override
Future passwordReset(BuildContext context) async {
  try {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: _emailController.text.trim());
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Password resent link sent! Check Your Email"),
          );
        });
  } on FirebaseAuthException catch (e) {
    print(e);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        });
  }
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.withOpacity(0.5),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Enter Your Email to reset your password..",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: reusableTextField(
                "Your Account Email",
                "Enter Your Account Email",
                Icons.email,
                false,
                _emailController,
                (value) => null),
          ),
          MaterialButton(
            onPressed: () {
              passwordReset(context);
            },
            child: Text(
              "Reset Password",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.deepPurple,
          ),
        ],
      ),
    );
  }
}
