import 'package:flutter/material.dart';
import './signup.dart';
import './reset.dart';



class LoginPage extends StatefulWidget {
  @override
  createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey key1 = new GlobalKey<FormState>();
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
                    width: 100.0,
                    margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 5.0),
                    child: Text(
                      "OR WITH",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 120.0,
                        height: 45.0,
                        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: RaisedButton(
                          color: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          onPressed: () {},
                          child: Text(
                            "FACEBOOK",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        height: 45.0,
                        width: 120.0,
                        margin: EdgeInsets.fromLTRB(30.0, 5.0, 0.0, 0.0),
                        child: RaisedButton(
                          color: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          onPressed: (){},
                          child: Text(
                            "GOOGLE",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                          MaterialPageRoute(builder: (context) => SignupPage()),
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPage()),
                          );
                        },
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}

// Create a Form widget
Widget formUI(context, key) {
  String email, password;
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
            onSaved: (String val) {
              email = val;
            },
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
            onSaved: (String val) {
              password = val;
            },
          ),
        ),
      ),
      Container(
        width: 150.0,
        height: 45.0,
        margin: EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 0.0),
        child: RaisedButton(
          color: Colors.purple,
          padding: EdgeInsets.all(10.0),
          onPressed: () {},
          child: Text(
            "Login",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
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
