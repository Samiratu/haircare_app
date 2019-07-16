import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './ssignup.dart';
import './crud.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final database = Firestore.instance;
bool submitted = false;

var boxDecor = BoxDecoration(
  border: Border.all(color: Colors.black, width: 1.0, style: BorderStyle.solid),
  borderRadius: BorderRadius.circular(25.0),
);

var textDecor = TextStyle(
  color: Colors.purple,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

class Register extends StatefulWidget {
  createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register>
    with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WELCOME",
          style: TextStyle(
              fontSize: 24.0,
              letterSpacing: 3.0,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          // onTap: ,
          controller: controller,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.people),
              text: "Customer",
            ),
            Tab(
              icon: Icon(Icons.person),
              text: "Stylist",
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[SignupPage(), StylistSignup()],
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  createState() {
    return SignupPageState();
  }
}

class SignupPageState extends State<SignupPage> {
  final key1 = new GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController cpassword = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  updateSubmitted() {
    setState(() {
      submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.fromLTRB(30.0, 0.0, 10.0, 15.0),
          child: ListView(children: <Widget>[
            //login page title
            Text(
              "BEAUTY AT YOUR FINGER TIPS",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  wordSpacing: 5.0,
                  letterSpacing: 3.0),
            ),

            Form(
              key: key1,
              child: Column(children: <Widget>[
                Container(
                  width: 250.0,
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                  child: Text(
                    "Full Names",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                          style: BorderStyle.solid),
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
                    controller: name,
                  ),
                ),
                Container(
                  width: 250.0,
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                  child: Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: "example@domain.com",
                      hintStyle: TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                    validator: validateEmail,
                    controller: email,
                  ),
                ),
                Container(
                  width: 250.0,
                  padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                  child: Text(
                    "Phone",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: "250 700 000 000",
                        hintStyle: TextStyle(
                          fontSize: 11.0,
                        )),
                    validator: validatephone,
                    controller: phone,
                  ),
                ),
                Container(
                  width: 250.0,
                  padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                  child: Text(
                    "Address",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: "KG 644 st, 15",
                        hintStyle: TextStyle(
                          fontSize: 11.0,
                        )),
                    validator: validateAddress,
                    controller: address,
                  ),
                ),
                Container(
                  width: 250.0,
                  padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                  child: Text(
                    "Password",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: "...........",
                        hintStyle: TextStyle(
                          fontSize: 11.0,
                        )),
                    validator: validatePassword,
                    controller: password,
                  ),
                ),
                Container(
                  width: 250.0,
                  padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                  child: Text(
                    "Confirm password",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: ".........",
                        hintStyle: TextStyle(
                          fontSize: 11.0,
                        )),
                    validator: validatePassword,
                    controller: cpassword,
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
                      "Create Account",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    onPressed: () {
                      if (key1.currentState.validate()) {
                        updateSubmitted();
                        key1.currentState.save();
                        if (submitted) {
                          print("object");
                          createUser(context, email.text, password.text, name,
                              phone, address);
                        } else {
                          showAlert(context);
                        }
                      } else {
                        return null;
                      }
                    },
                  ),
                )
              ]),
            ),
          ]),
        ),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }
}

Future<FirebaseUser> createUser(
    context, String email, String password, name, phone, address, [String category]) async {
  FirebaseUser user = await _auth
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((user) {
    createData(user.uid, name.text, email, phone.text, address.text, context,category);
  }).catchError((er) {
    if (er.message
        .contains("The email address is already in use by another account")) {
      showAlert(context);
    }
  });
  return user;
}

void createData(String uid, String name, String email, String phone,
    String address, context, String category) async {
  print("called");
  DocumentReference ref = await database.collection('users').add({
    'uid': uid,
    'fullname': name,
    'email': email,
    'phone': phone,
    'address': address,
    'category':category
  }).then((f) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => LoginPage())));
  print(" ref is ${ref.documentID}");
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
  } else if (value.length != 12) {
    return "Phone number must 12 digits";
  } else if (!regExp.hasMatch(value)) {
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

Future<void> showAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Warning'),
        content: const Text('User with this email already exist.'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      );
    },
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









