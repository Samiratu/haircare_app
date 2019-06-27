import 'package:flutter/material.dart';
import './login.dart';

class ResetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ResetPageState();
  }
}

class ResetPageState extends State<ResetPage> {
  final key1 = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
          margin: EdgeInsets.fromLTRB(30.0, 50.0, 10.0, 15.0),
          child: ListView(children: <Widget>[
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
              child: formUI3(context, key1),
            ),
          ]),
        )));
  }
}

Widget formUI3(context, key) {
  String password, cpassword;
  return Column(children: <Widget>[
    Container(
      width: 250.0,
      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
      child: Text(
        "Password",
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.purple),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black, width: 1.0, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(25.0)),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(10.0),
            hintText: "...........",
            hintStyle: TextStyle(
              fontSize: 11.0,
            )),
        validator: validatePassword,
        onSaved: (String val) {
          password = val;
        },
      ),
    ),
    Container(
      width: 250.0,
      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
      child: Text(
        "Confirm password",
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.purple),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black, width: 1.0, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(25.0)),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(10.0),
            hintText: ".........",
            hintStyle: TextStyle(
              fontSize: 11.0,
            )),
        validator: validatePassword,
        onSaved: (String val) {
          cpassword = val;
        },
      ),
    ),
    Container(
      width: 160.0,
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: RaisedButton(
        padding: EdgeInsets.all(10.0),
        color: Colors.purple,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0)),
        child: Text(
          "Reset",
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        onPressed: () {
          if (key.currentState.validate() && cpassword == password) {
            key.currentState.save();
            print("Password $password");
            print("Confirmed $cpassword");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          } else {
            return null;
          }
        },
      ),
    )
  ]);
}
