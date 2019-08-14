import 'package:flutter/material.dart';
import './stylist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  final String stylistName;
  final String stylistEmail;
  final String stylistPhone;
  final String stylistAddress;
  final String stylistUrl;
  const ProfilePage(
      {Key key,
      this.stylistName,
      this.stylistEmail,
      this.stylistPhone,
      this.stylistAddress,
      this.stylistUrl})
      : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController newName = TextEditingController();
  final TextEditingController newPhone = TextEditingController();
  final TextEditingController newAddress = TextEditingController();
  bool isLoginStylist = false;
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
                                    dialogImage();
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
                                onPressed: () {},
                              ),
                            )
                          : Container()
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(20.0, 10.0, 12.0, 0.0),
                      width: 150.0,
                      child: Text(
                        "Sarah C is a very talented stylist who was educated at Capri in New Lenox."
                        " She does beautiful highlights, ombres, "
                        "airbrush makeup and but one of her expertise is balayage. "
                        "She is part of our On Location and In Salon Wedding team "
                        "all of her brides LOVE her work.",
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ))
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
        onPressed: () {},
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
          "My work",
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
                        labelText: 'Full Name', hintText: 'eg. John Smith'),
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
                      labelText: 'Phone Number', hintText: 'eg. 237677204981'),
                ),
                TextFormField(
                  controller: newAddress,
                  decoration: new InputDecoration(
                      labelText: 'Address', hintText: 'eg. Kigali'),
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

  void dialogImage() {}

  void updateName() async {
   await  Firestore.instance.collection('users')
        .document('-Lk9Ib34kMAgOth9gE1Z')
        .updateData({'fullname': '${newName.text}'}).catchError((e){
          print(e.toString());
   });
  }

  void updateContact() async {
    final documentReference = Firestore.instance
        .collection("users")
        .where("email", isEqualTo: widget.stylistEmail);
    Firestore.instance
        .document("$documentReference")
        .updateData({'phone': '$newPhone', 'address': '$newAddress'});
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
}
