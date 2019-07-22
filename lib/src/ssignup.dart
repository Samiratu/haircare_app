import 'package:flutter/material.dart';
import './signup.dart';
import './crud.dart';



bool submitted = false;

//  this is the class for the stylist Signup.
class StylistSignup extends StatefulWidget {
  @override
  createState() {
    return StylistSignupState();
  }
}

class StylistSignupState extends State<StylistSignup> {
  final key2 = new GlobalKey<FormState>();
  final TextEditingController fname = TextEditingController();
  final TextEditingController mphone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController cpassword = TextEditingController();
  CRUDMethods crudObject = new CRUDMethods();

  updateSubmitted() {
    setState(() {
      submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(30.0, 20.0, 10.0, 15.0),
        child: ListView(
          children: <Widget>[
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
              key: key2,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 250.0,
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                    child: Text("Fullnames", style: textDecor),
                  ),
                  Container(
                    decoration: boxDecor,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: " Mary James",
                          hintStyle: TextStyle(
                            fontSize: 8.0,
                          )),
                      validator: validatename,
                      controller: fname,
                    ),
                  ),
                  Container(
                    width: 250.0,
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                    child: Text(
                      "Email Adress",
                      style: textDecor,
                    ),
                  ),
                  Container(
                    decoration: boxDecor,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: " example@domain.com",
                          hintStyle: TextStyle(
                            fontSize: 8.0,
                          )),
                      validator: validateEmail,
                      controller: email,
                    ),
                  ),
                  Container(
                    width: 250.0,
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                    child: Text(
                      "Phone Number",
                      style: textDecor,
                    ),
                  ),
                  Container(
                    decoration: boxDecor,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: " 250 700 000 000",
                          hintStyle: TextStyle(
                            fontSize: 8.0,
                          )),
                      validator: validatephone,
                      controller: mphone,
                    ),
                  ),
                  Container(
                    width: 250.0,
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                    child: Text(
                      "Category",
                      style: textDecor,
                    ),
                  ),
                  Container(
                    decoration: boxDecor,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: "Braids, weave, Crochet,Make up etc",
                          hintStyle: TextStyle(
                            fontSize: 8.0,
                          )),
                      validator: validatename,
                      controller: category,
                    ),
                  ),
                  Container(
                    width: 250.0,
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                    child: Text(
                      "Address",
                      style: textDecor,
                    ),
                  ),
                  Container(
                    decoration: boxDecor,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: "KG 644 st, 15",
                          hintStyle: TextStyle(
                            fontSize: 8.0,
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
                      style: textDecor,
                    ),
                  ),
                  Container(
                    decoration: boxDecor,
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
                      style: textDecor,
                    ),
                  ),
                  Container(
                    decoration: boxDecor,
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
                    width: 100.0,
                    padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(10.0),
                      color: Colors.purple,
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      onPressed: () {
                        if (key2.currentState.validate()) {
                          key2.currentState.save();
                          crudObject.createUser(context, email.text,
                              password.text, fname, mphone, address,category.text);
//                          if (submitted) {
//                            crudObject.createUser(context, email.text,
//                                password.text, fname, mphone, address,category.text);
//                          }
//                          else {
//                            crudObject.showAlert(context);
//                          }
                        } else {
                          return null;
                        }
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
