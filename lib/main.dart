import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kash_coder_cricket_clans/pages/home_page.dart';
import 'package:kash_coder_cricket_clans/pages/login_page.dart';
import 'package:kash_coder_cricket_clans/pages/routes.dart';
import 'package:kash_coder_cricket_clans/pages/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness ==  Brightness.dark;
    return MaterialApp(
      theme: ThemeData(
        brightness:isDark? Brightness.dark: Brightness.light
      ),
      debugShowCheckedModeBanner: false ,
      home: Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomePage();
              }
              else {
                return LoginPage();
              }
            }
        ),
      ),routes: {
        MyRoutes.loginPage: (context) => LoginPage(),
      MyRoutes.signUpPage: (context) => SignUp(),
      MyRoutes.homePage: (context) => HomePage(),

    },
    );
  }
}


