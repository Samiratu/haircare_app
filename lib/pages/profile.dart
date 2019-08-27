import 'package:flutter/material.dart';
import 'package:haircare_app/pages/stylist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:haircare_app/pages/appointment.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import './availability.dart';
import 'package:path/path.dart' as p;
import 'package:rating_bar/rating_bar.dart';
import './crud.dart';

class ProfilePage extends StatefulWidget {
  final String stylistID;
  final String stylistName;
  final String stylistEmail;
  final String stylistPhone;
  final String stylistAddress;
  final String stylistUrl;
  final String about;
  final double ratingCount;
  final double totalRating;
  final double averageRating;
  const ProfilePage({
    Key key,
    this.stylistID,
    this.stylistName,
    this.stylistEmail,
    this.stylistPhone,
    this.stylistAddress,
    this.stylistUrl,
    this.about,
    this.ratingCount,
    this.totalRating,
    this.averageRating,
  }) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  CRUDMethods _crudMethods = CRUDMethods();
  final TextEditingController newName = TextEditingController();
  final TextEditingController newPhone = TextEditingController();
  final TextEditingController newAddress = TextEditingController();
  final TextEditingController newAbout = TextEditingController();
  double _ratingHeart = 0.0;
  double count = 0.0;
  double rating = 0.0;
  double summedRating = 0.0;
  double average;
  bool isLoginStylist = false;
  File _imageFile;
  String imageUrl;
  bool notSubmitted = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      count = widget.ratingCount;
//      rating = widget.totalRating;
      summedRating = widget.totalRating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StylistPage()),
            );
          },
        ),
        title: Text(
          "${widget.stylistName}",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Builder(
        builder: (context) => Container(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 75.0,
                          backgroundColor: Colors.purple,
                          child: ClipOval(
                            child: SizedBox(
                              width: 140.0,
                              height: 140.0,
                              child: (widget.stylistUrl != null)
                                  ? Image.network(
                                      "${widget.stylistUrl}",
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset('images/profile.jpg',
                                      fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ),
                      isLoginStylist || loginStylist()
                          ? Padding(
                              padding: EdgeInsets.all(5.0),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    size: 40.0,
                                  ),
                                  onPressed: () {
                                    getImageUrl();
                                  }),
                            )
                          : Container()
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(120.0, 15.0, 0.0, 0.0),
                        child: Text(
                          "${widget.stylistName}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      isLoginStylist || loginStylist()
                          ? Container(
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  dialogName();
                                },
                              ),
                            )
                          : Container()
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(75.0, 5.0, 0.0, 0.0),
                        child: Text(
                          "${widget.stylistPhone} | ${widget.stylistAddress}",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      isLoginStylist || loginStylist()
                          ? Container(
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  dialogContact();
                                },
                              ),
                            )
                          : Container()
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buttonWork(),
                      buttonBook(),
                    ],
                  ),
                  Container(
                    height: 17.0,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                        child: isLoginStylist || loginStylist()
                            ? Text(
                                "About me",
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "About stylist",
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                      isLoginStylist || loginStylist()
                          ? Container(
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  aboutDialog();
                                },
                              ),
                            )
                          : Container()
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20.0, 10.0, 12.0, 0.0),
                    width: 150.0,
//                    height: 100.0,
                    child: Text(
                      widget.about,
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  isLoginStylist || loginStylist()
                      ? Container()
                      : Card(
                          child: Container(
                            margin: EdgeInsets.all(15.0),
                            child: Form(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 15.0,
                                  ),
                                  Container(
                                    child: Text(
                                      "Rate this stylist",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: RatingBar(
                                      onRatingChanged: (rating) =>
                                          setState(() => _ratingHeart = rating),
                                      filledIcon: Icons.star,
                                      emptyIcon: Icons.star_border,
                                      halfFilledIcon: Icons.star_half,
                                      isHalfAllowed: true,
                                      filledColor: Colors.purple,
                                      emptyColor: Colors.purple,
                                      halfFilledColor: Colors.purple,
                                      size: 30,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      " Rating: $_ratingHeart",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 10.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(8.0),
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                    ),
                                    child: notSubmitted
                                        ? FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                count = count + 1.0;
                                              });
                                              if (_ratingHeart > 0.0 &&
                                                  notSubmitted) {
                                                setState(() {
                                                  rating = summedRating +
                                                      _ratingHeart;
                                                  summedRating = summedRating +
                                                      _ratingHeart;
                                                  average =
                                                      summedRating / count;
                                                });
                                                updateRating();
                                              }
                                              setState(() {
                                                notSubmitted = false;
                                              });
                                            },
                                            child: Text(
                                              "SUBMIT",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0),
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.all(10.0),
                                            child: Center(
                                                child: Text("Thank you")),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
      ),
    );
  }

  Widget buttonBook() {
    return Container(
      width: 120.0,
      height: 45.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.purple),
      margin: EdgeInsets.all(5.0),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AvailablePage(),
            ),
          );
        },
        child: Text(
          "Book Now",
          style: TextStyle(color: Colors.white, fontSize: 11.0),
        ),
      ),
    );
  }

  Widget buttonWork() {
    return Container(
      width: 120.0,
      height: 45.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.purple),
      margin: EdgeInsets.all(5.0),
      child: FlatButton(
        onPressed: () {},
        child: Text(
          "Sample work",
          style: TextStyle(color: Colors.white, fontSize: 11.0),
        ),
      ),
    );
  }

  void dialogName() async {
    return showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text("Update Name"),
              content: Column(
                children: <Widget>[
                  TextFormField(
                    controller: newName,
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Full Name', hintText: widget.stylistName),
                  ),
                ],
              ),
              actions: <Widget>[
                new FlatButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                new FlatButton(
                    child: const Text('UPDATE'),
                    onPressed: () {
                      updateName();
                      Navigator.pop(context);
                    })
              ],
            ),
          );
        });
  }

  void dialogContact() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Contact Details"),
          content: ListView(
            children: <Widget>[
              TextFormField(
                controller: newPhone,
                decoration: new InputDecoration(
                    labelText: 'Phone Number', hintText: widget.stylistPhone),
              ),
              TextFormField(
                controller: newAddress,
                decoration: new InputDecoration(
                    labelText: 'Address', hintText: widget.stylistAddress),
              ),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('UPDATE'),
                onPressed: () {
                  updateContact();
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  void aboutDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add short bio"),
            content: ListView(
              children: <Widget>[
                Container(
                  height: 500.0,
                  margin: EdgeInsets.only(top: 50.0),
                  child: TextFormField(
                    controller: newAbout,
                    autofocus: true,
                    maxLines: 12,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('UPDATE'),
                  onPressed: () {
                    updateAbout();
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  void updateName() async {
    String id = await getDocumentID();
    await Firestore.instance
        .collection('users')
        .document(id)
        .updateData({'fullname': '${newName.text}'}).catchError((e) {
      print(e.toString());
    });
  }

  void updateRating() async {
    String id = await getRateDocumentID();
    await Firestore.instance.collection('users').document(id).updateData({
      'ratingCount': count,
      'averageRating': average,
      'totalRating': summedRating
    }).catchError((e) {
      print(e.toString());
    });
  }

  void updateAbout() async {
    String id = await getDocumentID();
    await Firestore.instance
        .collection('users')
        .document(id)
        .updateData({'about': '${newAbout.text}'}).catchError((e) {
      print(e.toString());
    });
  }

  getDocumentID() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var docs = await Firestore.instance
        .collection('users')
        .where("uid", isEqualTo: user.uid)
        .getDocuments();
    var d = docs.documents;
    var user1 = d[0];
    return user1.documentID;
  }

  getRateDocumentID() async {
    var docs = await Firestore.instance
        .collection('users')
        .where("uid", isEqualTo: widget.stylistID)
        .getDocuments();
    var d = docs.documents;
    var user1 = d[0];
    return user1.documentID;
  }

  void updateContact() async {
    String id = await getDocumentID();
    await Firestore.instance.collection('users').document(id).updateData({
      'phone': '${newPhone.text}',
      'address': '${newAddress.text}'
    }).catchError((e) {
      print(e.toString());
    });
  }

  loginStylist() {
    FirebaseAuth.instance.currentUser().then((user) {
      if (user != null && user.email == widget.stylistEmail) {
        setState(() {
          isLoginStylist = true;
        });
      }
    });
    return false;
  }

  void getImageUrl() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
    String fileName = p.basename(_imageFile.path);
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    fileName = p.basename(_imageFile.path);
    String downloadAddress = await reference.getDownloadURL();
    print("Image URL : $downloadAddress");
    setState(() {
      imageUrl = downloadAddress.toString();
    });
    String id = await getDocumentID();
    await Firestore.instance
        .collection('users')
        .document(id)
        .updateData({'photoURL': imageUrl}).catchError((e) {
      print(e.toString());
    });
  }
}
