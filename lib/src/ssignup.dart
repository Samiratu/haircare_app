import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';
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
  final TextEditingController password = TextEditingController();
  final TextEditingController cpassword = TextEditingController();
  final bool stylist = true;
  File _imageFile;
  String _downloadUrl;
  CRUDMethods crudObject = new CRUDMethods();
  var categories = [
    "Locks",
    "Braids",
    "Corn Rows",
    "Crochet",
    "Weave",
    "Relaxing and Styling",
    "Natural hair braiding/styling"
  ];
  String selectedCategory;

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
                        ),
                      ),
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
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: "select category you do best",
                          hintStyle: TextStyle(
                            fontSize: 8.0,
                          ),
                        ),
                        items: categories.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Center(
                              child: Text(dropDownStringItem),
                            ),
                          );
                        }).toList(),
                        onChanged: (String currentSelected) {
                          itemSelected(currentSelected);
                        },
                        value: selectedCategory,
                        validator: validatename,
                      )),
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
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                    child: Text(
                      "Profile Picture ",
                      style: textDecor,
                    ),
                  ),
                  Container(
//                      decoration: boxDecor,
                      child: FlatButton(
                        color: Colors.purple,
                        child: Icon(
                          Icons.file_upload,
                          size: 40.0,
                        ),
                        onPressed: () {
                          getImageUrl();
                        },
                      )),
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
                            crudObject.createStylist(
                                context,
                                email.text,
                                password.text,
                                fname,
                                mphone,
                                address,
                                _downloadUrl,
                                selectedCategory);
                          } else {
                            return null;
                          }
                        }),
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

  void itemSelected(String currentSelected) {
    setState(() {
      this.selectedCategory = currentSelected;
    });
  }

  Future getImageUrl() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
    String fileName = basename(_imageFile.path);
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    fileName = basename(_imageFile.path);
    String downloadAddress = await reference.getDownloadURL();
    print("Image URL : $downloadAddress");
    setState(() {
      _downloadUrl = downloadAddress.toString();
    });
  }
}
