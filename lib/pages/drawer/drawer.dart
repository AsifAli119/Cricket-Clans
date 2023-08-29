import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kash_coder_cricket_clans/pages/routes.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late Future<String> _usernameFuture;

  @override
  void initState() {
    super.initState();
    _usernameFuture = _fetch();
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser?.email;
    var url = "https://picsum.photos/250?image=9";
    return Drawer(
      child: ListView(
        children: [
          FutureBuilder<String>(
            future: _usernameFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return UserAccountsDrawerHeader(
                  accountName: Text("Loading data..."),
                  accountEmail: Text(currentUser!),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(url),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return UserAccountsDrawerHeader(
                  accountName: Text("Error fetching username"),
                  accountEmail: Text(currentUser!),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(url),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else {
                return UserAccountsDrawerHeader(
                  accountName: Text(snapshot.data!),
                  accountEmail: Text(currentUser!),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(url),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.black),
            title: Text(
              "Home",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.black),
            title: Text(
              "Profile",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.search, color: Colors.black),
            title: Text(
              "Search",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.share, color: Colors.black),
            title: Text(
              "Share",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.black),
            title: Text(
              "Rate us",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.black),
            title: Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, MyRoutes.loginPage);
            },
          ),// Rest of the ListTile items...
        ],
      ),
    );
  }

  Future<String> _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      Map<String, dynamic>? data = snapshot.data();
      if (data != null) {
        String username = data['username'];
        print(username);
        return username;
      } else {
        print("No user data found in Firestore");
      }
    } else {
      print("No authenticated user");
    }

    return "No Username"; // Return a default value if no username is found
  }

}
