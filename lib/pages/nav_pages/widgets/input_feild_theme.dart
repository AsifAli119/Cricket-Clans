import 'package:flutter/material.dart';
class TextForFieldTheme{
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
    prefixIconColor: Colors.black,
    floatingLabelStyle: TextStyle(color: Colors.grey),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Colors.grey)
    )
  );
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
    prefixIconColor: Colors.white,
    floatingLabelStyle: TextStyle(color: Colors.white),
    focusedBorder:  OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Colors.white)
    )
  );
}