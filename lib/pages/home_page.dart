import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kash_coder_cricket_clans/pages/drawer/drawer.dart';
import 'package:kash_coder_cricket_clans/pages/nav_pages/add_post.dart';
import 'package:kash_coder_cricket_clans/pages/nav_pages/nav_home_page.dart';
import 'package:kash_coder_cricket_clans/pages/nav_pages/notification_page.dart';
import 'package:kash_coder_cricket_clans/pages/nav_pages/profile/profile_page.dart';
import 'package:kash_coder_cricket_clans/pages/nav_pages/widgets/profile_widgets.dart';
import 'package:kash_coder_cricket_clans/pages/routes.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pages = [
    NavHomePage(),
    AddPost(),
    NotificationPage(),
  ];
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ));
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image(
                              image:
                                  AssetImage("assets/images/profile_me.jpeg"),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
              backgroundColor: Colors.deepPurple,
              title: const Text("CricketClans"),
            ),
      body: pages[currentIndex],
      drawer: MyDrawer(),
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        backgroundColor: Colors.white,
        color: Colors.deepPurple,
        animationDuration: Duration(milliseconds: 300),
        onTap: onTap,
        items: [
          Icon(LineAwesomeIcons.home, color: Colors.white),
          Icon(
            LineAwesomeIcons.plus_circle,
            color: Colors.white,
          ),
          Icon(LineAwesomeIcons.bell, color: Colors.white)
        ],
      ),
    );
  }
}
