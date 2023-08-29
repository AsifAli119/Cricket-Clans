import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kash_coder_cricket_clans/pages/nav_pages/profile/profile_page.dart';
import 'package:kash_coder_cricket_clans/utilis/reusable_profile_text_feilds.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../utilis/reusablecode.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final userCollection = FirebaseFirestore.instance.collection('users');

  final _nameTxtController = TextEditingController();
  final _mailTxtController = TextEditingController();
  final _phnTxtController = TextEditingController();
  final _passTxtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var btnColor = isDark ? Colors.yellow : Colors.black;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          },
          icon: const Icon(
            LineAwesomeIcons.angle_left,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          image: AssetImage("assets/images/profile_me.jpeg"),
                        )),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.yellow,
                      ),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: getCurrentUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      var userData = snapshot.data?.data();
                      _nameTxtController.text = userData?['username'] ?? '';
                      _mailTxtController.text = userData?['email'] ?? '';
                      _phnTxtController.text = userData?['phone no'] ?? '';
                      return Column(
                        children: [
                          Text(
                            _nameTxtController.text.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    }
                  }),
              SizedBox(height: 25,),
              Form(
                child: Column(
                  children: [
                    FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: getCurrentUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          var userData = snapshot.data?.data();
                          _nameTxtController.text = userData?['username'] ?? '';
                          _mailTxtController.text = userData?['email'] ?? '';
                          _phnTxtController.text = userData?['phone no'] ?? '';

                          return Column(
                            children: [
                              ReusableTextFieldFutureBuilder(
                                controller: _nameTxtController,
                              ),
                              SizedBox(height: 20),
                              ReusableTextFieldFutureBuilder(
                                controller: _mailTxtController,
                              ),
                              SizedBox(height: 20),
                              ReusableTextFieldFutureBuilder(
                                  controller: _phnTxtController),
                              SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const UpdateProfile(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: btnColor,
                                    side: BorderSide.none,
                                    shape: const StadiumBorder(),
                                  ),
                                  child: Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                        color: isDark
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
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

  Future<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserData() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> ds =
            await userCollection.doc(user.uid).get();
        return ds;
      } else {
        throw "User not found!";
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
