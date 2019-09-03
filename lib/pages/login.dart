import 'package:flutter/material.dart';
import 'package:haircare_app/pages/signup.dart';
import 'package:haircare_app/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:haircare_app/pages/crud.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {

  @override
  createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  CRUDMethods crudObj = new CRUDMethods();
  final GlobalKey key1 = new GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      title: "BEAUTY AT YOUR FINGER TIPS",
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.fromLTRB(30.0, 50.0, 10.0, 15.0),
          child: ListView(
            children: <Widget>[
              //login page title
              Text(
                "BEAUTY AT YOUR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    wordSpacing: 5.0,
                    letterSpacing: 3.0),
              ),
              Text("FINGER TIPS",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      wordSpacing: 5.0,
                      letterSpacing: 3.0)),

              Form(
                key: key1,
                child: formUI(context, key1),
              ),

              Column(
                children: <Widget>[
                  Container(
                    width: 200.0,
                    margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          letterSpacing: 1.0),
                    ),
                  ),
                  Container(
                    width: 150.0,
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: FlatButton(
                      child: Text(
                        "Register Here",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.blueAccent,
                            letterSpacing: 1.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: Text(
                      "Forgot your password?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          letterSpacing: 1.0),
                    ),
                  ),
                  Container(
                    // width: 150.0,
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                      child: FlatButton(
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.blueAccent,
                              letterSpacing: 1.0),
                        ),
                        onPressed: () {},
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

// Create a Form widget
  Widget formUI(context, key) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 5.0),
          width: 200.0,
          child: Text("Email Address",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                  fontSize: 16.0)),
        ),
        Container(
          height: 45.0,
          width: 500.0,
          margin: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.purple, width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10.0)),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "example@domain.com",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.0,
                  )),
              validator: validateEmail,
              controller: email,
            ),
          ),
        ),
        Container(
          width: 200.0,
          margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: Text("Password",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                  fontSize: 16.0)),
        ),
        Container(
          height: 45.0,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.purple, width: 1.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10.0)),
          margin: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
          child: Container(
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "...........",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
              validator: validatePassword,
              controller: password,
            ),
          ),
        ),
        Container(
          width: 150.0,
          height: 45.0,
          margin: EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 0.0),
          child: !isLoading ?  RaisedButton(
            color: Colors.purple,
            padding: EdgeInsets.all(10.0),
            onPressed: () {

              if (key.currentState.validate()) {
                setState(() {
                  isLoading = true;
                });
                signInUser(context, email.text, password.text);
              }
            },
            child: Text(
              "Sign In",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ): Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  Future<FirebaseUser> signInUser(
      context, String email, String password) async {
    FirebaseUser user = await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) { Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    ).then((f){
      setState(() {
        isLoading = false;
      });
    });
    print(user.email);
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });
      _showAlert(context);
      print(err);
    });
    return user;
  }


  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "email is required";
    } else if (!regExp.hasMatch(value)) {
      return "invalid email";
    } else {
      return null;
    }
  }

  String validatePassword(var value) {
    if (value.length == 0) {
      return "password is required";
    } else if (value.length < 6) {
      return "password too short";
    } else {
      return null;
    }
  }

  Future<void> _showAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: const Text('Email or Password is incorrect'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}