import 'package:flutter/material.dart';
import './login.dart';

class SignupPage extends StatefulWidget {
  @override
  createState() {
    return SignupPageState();
  }
}

class SignupPageState extends State<SignupPage> {
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
              child: formUI2(context, key1),
            ),
          ]),
        )));
  }
}

Widget formUI2(context, key) {
  String name, email, phone, address, password, cpassword;
  return Column(children: <Widget>[
    Container(
      width: 250.0,
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
      child: Text(
        "Full Names",
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
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10.0),
          hintText: "Mary James",
          hintStyle: TextStyle(
            fontSize: 11.0,
          ),
        ),
        validator: validatename,
        onSaved: (String val) {
          name = val;
        },
      ),
    ),
    Container(
      width: 250.0,
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
      child: Text(
        "Email",
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
          hintText: "example@domain.com",
          hintStyle: TextStyle(
            fontSize: 11.0,
          ),
        ),
        validator: validateEmail,
        onSaved: (String val) {
          email = val;
        },
      ),
    ),
    Container(
      width: 250.0,
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
      child: Text(
        "Phone",
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
            hintText: "250 700 000 000",
            hintStyle: TextStyle(
              fontSize: 11.0,
            )),
        validator: validatephone,
        onSaved: (String val) {
          phone = val;
        },
      ),
    ),
    Container(
      width: 250.0,
      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
      child: Text(
        "Address",
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
            hintText: "KG 644 st, 15",
            hintStyle: TextStyle(
              fontSize: 11.0,
            )),
        validator: validateAddress,
        onSaved: (String val) {
          address = val;
        },
      ),
    ),
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
          "Sign Up",
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        onPressed: () {
          if (key.currentState.validate()) {
            key.currentState.save();
            print("Name $name");
            print("Email $email");
            print("Phone $phone");
            print("Address $address");
            print("Password $password");
            print("Confirmed $cpassword");
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
          }else{
            return null;
          }
         
        },
      ),
    )
  ]);
}

String validatename(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
   RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
}

String validatephone(String value) {
  String patttern = r'(^[0-9]*$)';
   RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Phone is Required";
    } else if(value.length != 12){
      return "Phone number must 12 digits";
    }else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
}

String validateAddress(String value) {
  // String patttern = r'(^[a-zA-Z ]*$)';
  if (value.length == 0) {
    return "Address is required";
  } else {
    return null;
  }
}


