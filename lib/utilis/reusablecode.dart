import 'package:flutter/material.dart';

import '../pages/routes.dart';
Image logoWidget(String imageName){
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
  );
}
TextFormField reusableTextField(String label, String hint, IconData icon, bool isPasswordType, TextEditingController controller, FormFieldValidator formFieldValidator,) {
  return TextFormField(
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      validator: formFieldValidator,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white.withOpacity(0.9),
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.9),
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.9),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(width: 1, style: BorderStyle.none, color: Colors.white),
        ),
      ),
      keyboardType: isPasswordType? TextInputType.visiblePassword: TextInputType.emailAddress,
    );
}
//code for button
Container reusableButton(BuildContext context, bool isLogin, VoidCallback onTap) {
  return Container(
    width: 150,
    height: 50,
    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(90),
    ),
    child: ElevatedButton(
      onPressed: onTap, // Call the provided onTap callback directly
      child: Text(
        isLogin ? "LOGIN" : "SIGN UP",
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          }
          return Colors.white;
        }),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    ),
  );
}
//code for signupOption
Row signUpOption(context, bool isSignUp){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text( isSignUp?"Don't have an account ? ": "Already have an account ? ",
        style: TextStyle(color: Colors.white70),),
      GestureDetector(
        onTap: (){ isSignUp?
          Navigator.pushNamed(context, MyRoutes.signUpPage): Navigator.pushNamed(context, MyRoutes.loginPage);
        },
        child: Text( isSignUp?
          "Register now": "Login now",
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold
          ),
        ),
      )
    ],
  );
}