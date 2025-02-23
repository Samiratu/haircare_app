import 'package:flutter/material.dart';
import './pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './pages/home.dart';
import './pages/availability.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      FirebaseAuth.instance.currentUser() != null?HomePage():LoginPage(),
    );
  }
}