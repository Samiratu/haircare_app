import 'package:flutter/material.dart';
import './home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  String userIn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displayUser().then((f){
      setState(() {
        userIn =f;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(right: 40.0),
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text('$userIn'),
            currentAccountPicture: Image.asset('images/profile.jpg',),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.purple,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_view_day,
              color: Colors.purple,
            ),
            title: Text("My Bookings"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.shop,
              color: Colors.purple,
            ),
            title: Text("Buy hair products"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.purple,
            ),
            title: Text("Home"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.purple,
            ),
            title: Text("About"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.purple,
            ),
            title: Text("Sign Out"),
            onTap: () {
              signoutUser();
            },
          ),
        ],
      ),
    );
  }
}

void signoutUser() {
  FirebaseAuth.instance.signOut();
}

displayUser() async {
  var auth = await FirebaseAuth.instance.currentUser();
  if (auth != null) {
    var email = auth.email;
    return email.toString();
  } else {
    return " ";
  }
}

