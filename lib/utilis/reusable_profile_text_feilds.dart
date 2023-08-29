import 'package:flutter/material.dart';

class ReusableTextFieldFutureBuilder extends TextFormField {
  ReusableTextFieldFutureBuilder({
    dynamic initialValue,
    String label = "",
    String hint = "",
    IconData? icon,
    bool isPasswordType = false,
    required TextEditingController controller,
  }) : super(
    controller: controller,
    initialValue: initialValue,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(
      color: Colors.white.withOpacity(0.9),
    ),
    decoration: InputDecoration(
      prefixIcon: icon != null ? Icon(icon, color: Colors.white70) : null,
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
    keyboardType: isPasswordType ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}
