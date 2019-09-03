import 'package:flutter/material.dart';
import './signup.dart';
import './crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool submitted = false;

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
  double averageRating = 0.0;
  double totalRating = 0.0;
  int ratingCount = 0;
  final bool stylist = true;
  String about = "";
  var styles;
  String _downloadUrl =
      "https://firebasestorage.googleapis.com/v0/b/my-hairdressing-project.appspot.com/o/profile.jpg?alt=media&token=2580d9e6-be55-40c3-9bee-eb24dbf2e37a'";
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
  void initState() {
    // TODO: implement initState
    super.initState();
    Firestore.instance.collection("styles").getDocuments().then((f) {
      setState(() {
        styles = f.documents[0].data["style_names"];
      });
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
                      keyboardType: TextInputType.emailAddress,
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
                      keyboardType: TextInputType.number,
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
                      "Select styles you do",
                      style: textDecor,
                    ),
                  ),
                  styles != null
                      ? Container(
                          child: Wrap(
                            spacing: 5.0,
                            runSpacing: 3.0,
                            children: allCategories(styles),
                          ),
                        )
                      : LinearProgressIndicator(),
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
                            crudObject.createStylist(
                              context,
                              email.text,
                              password.text,
                              fname,
                              mphone,
                              address,
                              _downloadUrl,
                              about,
                              ratingCount,
                              averageRating,
                              totalRating,
                              selectedStyles,
                              selectedCategory,
                            );
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

  allCategories(styles) {
    var styleLists = new List<FilterChipWidget>();
    for (int i = 0; i < styles.length; i++) {
      styleLists.add(FilterChipWidget(chipName: styles[i]));
    }
    return styleLists;
  }

  void itemSelected(String currentSelected) {
    setState(() {
      this.selectedCategory = currentSelected;
    });
  }
}

List<String> selectedStyles = List();
class FilterChipWidget extends StatefulWidget {
  final String chipName;
  FilterChipWidget({Key key, this.chipName,})
      : super(key: key);
  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      selected: _isSelected,
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
          _isSelected && !selectedStyles.contains(widget.chipName)?selectedStyles.add(widget.chipName): print(selectedStyles.toString());
          print(selectedStyles);
      },
    );
  }
}
