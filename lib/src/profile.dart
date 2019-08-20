import 'package:flutter/material.dart';
import './stylist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './appointment.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

class ProfilePage extends StatefulWidget {
  final String stylistName;
  final String stylistEmail;
  final String stylistPhone;
  final String stylistAddress;
  final String stylistUrl;
  final String about;
  const ProfilePage(
      {Key key,
      this.stylistName,
      this.stylistEmail,
      this.stylistPhone,
      this.stylistAddress,
      this.stylistUrl,
      this.about})
      : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController newName = TextEditingController();
  final TextEditingController newPhone = TextEditingController();
  final TextEditingController newAddress = TextEditingController();
  final TextEditingController newAbout = TextEditingController();
  bool isLoginStylist = false;
  File _imageFile;
  String imageUrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    loginStylist();
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
                    height: 20.0,
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
                      isLoginStylist
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
                      isLoginStylist
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
                      isLoginStylist
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
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                        child: Text(
                          "About me",
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      loginStylist() || isLoginStylist
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
                 !isLoginStylist? Container(
                    margin: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Rate this stylist",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              starReview(),
                              starReview(),
                              starReview(),
                              starReview(),
                              starReview(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ):Container(),
                ],
              ),
            ),
      ),
    );
  }

  Widget buttonBook() {
    return Container(
      width: 150.0,
      height: 45.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), color: Colors.purple),
      margin: EdgeInsets.all(5.0),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentPage(
                    stylistName: "${widget.stylistName}",
                    stylistEmail: "${widget.stylistEmail}",
                  ),
            ),
          );
        },
        child: Text(
          "Book Me",
          style: TextStyle(color: Colors.white, fontSize: 11.0),
        ),
      ),
    );
  }

  Widget buttonWork() {
    return Container(
      width: 150.0,
      height: 45.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), color: Colors.purple),
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
        });
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

  Widget starReview() {
    return Container(
      margin: EdgeInsets.all(3.0),
      child: Icon(
        Icons.favorite_border,
        color: Colors.purple,
        size: 20.0,
      ),
    );
  }
}
