import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kash_coder_cricket_clans/pages/home_page.dart';
import 'package:kash_coder_cricket_clans/pages/nav_pages/profile/update_profile_page.dart';
import 'package:kash_coder_cricket_clans/pages/nav_pages/widgets/profile_widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userCollection = FirebaseFirestore.instance.collection('users');

  final _nameTxtController = TextEditingController();

  final _mailTxtController = TextEditingController();

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
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
            }, icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text(
          "My Profile",
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 3
                        )
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage("https://picsum.photos/250?image=9"),
                            loadingBuilder: (context, child, loadingProgress){
                              if(loadingProgress == null) return child;
                              return Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, object, stack) {
                              return Container(
                                child: Icon(
                                  Icons.error_outline, color: Colors.black,),
                              );
                            }
                          )),
                    ),
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
                      return Column(
                        children: [
                          SizedBox(height: 25,),
                          Text(
                            _nameTxtController.text.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),Text(
                            _mailTxtController.text,
                          ),
                        ],
                      );
                    }
                  }),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpdateProfile(),
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
                    style:
                        TextStyle(color: isDark ? Colors.black : Colors.white),
                  )),
              const SizedBox(height: 30),
              const Divider(),
              SizedBox(height: 10),
              // MENU
              ProfileMenuWidget(
                  title: "Settings",
                  icon: LineAwesomeIcons.cog,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Tournaments Joined",
                  icon: LineAwesomeIcons.gamepad,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Team Progress",
                  icon: LineAwesomeIcons.project_diagram,
                  onPress: () {}),
              const Divider(),
              ProfileMenuWidget(
                  title: "Information",
                  icon: LineAwesomeIcons.info,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.alternate_sign_out,
                  endIcon: false,
                  onPress: () {})
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
