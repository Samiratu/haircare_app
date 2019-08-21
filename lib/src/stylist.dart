import 'package:flutter/material.dart';
import './profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './crud.dart';
import './appointment.dart';
import './drawer.dart';
import './simage.dart';

class StylistPage extends StatefulWidget {
  @override
  createState() {
    return StylistPageState();
  }
}

class StylistPageState extends State<StylistPage> {
  CRUDMethods crudObject = new CRUDMethods();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  String stylistName;
  String stylistCategory;
  String stylistContact;
  QuerySnapshot stylists;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    crudObject.getData().then((results) {
      setState(() {
        stylists = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: _scaffoldKey,
          drawer: DrawerPage(),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.purple,
              ),
            ),
            title: Text(
              "Stylists",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.black),
            ),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.purple,
                ),
              )
            ],
          ),
          body: stylistProf(),
        ));
  }

  Widget stylistProf() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("users")
          .where(
            "stylist",
            isEqualTo: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StylistImage(
                                            imageUrl:
                                                "${snapshot.data.documents[index].data["photoURL"]}",
                                          )),
                                );
                              },
                              child: Container(
                                child: CircleAvatar(
                                    radius: 47.0,
                                    backgroundColor: Colors.purple,
                                    child: ClipOval(
                                      child: SizedBox(
                                          width: 90.0,
                                          height: 90.0,
                                          child: Image.network(
                                            "${snapshot.data.documents[index].data["photoURL"]}",
                                            fit: BoxFit.fill,
                                          )),
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "${snapshot.data.documents[index].data["fullname"]}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${snapshot.data.documents[index].data["category"]}",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${snapshot.data.documents[index].data["address"]}",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 17.0),
                                    child: Row(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            starReview(),
                                            starReview(),
                                            starReview(),
                                            starReview(),
                                            starReview(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  button("Book Now", snapshot, index),
                                  Container(
                                    margin: EdgeInsets.only(left: 7.0),
                                    width: 80,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                    ),
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProfilePage(
                                                  stylistName:
                                                      "${snapshot.data.documents[index].data["fullname"]}",
                                                  stylistEmail:
                                                      "${snapshot.data.documents[index].data["email"]}",
                                                  stylistPhone:
                                                      "${snapshot.data.documents[index].data["phone"]}",
                                                  stylistAddress:
                                                      "${snapshot.data.documents[index].data["address"]}",
                                                  stylistUrl:
                                                      "${snapshot.data.documents[index].data["photoURL"]}",
                                                  about:
                                                      "${snapshot.data.documents[index].data["about"]}",
                                                  ratingCount: snapshot
                                                      .data
                                                      .documents[index]
                                                      .data["ratingCount"],
                                                  averageRating: snapshot
                                                      .data
                                                      .documents[index]
                                                      .data["ratingCount"],
                                                ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "View Details",
                                        style: TextStyle(
                                            fontSize: 8.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget button(String text, snapshot, index) {
    return Container(
      width: 80.0,
      height: 40.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.purple),
      margin: EdgeInsets.all(15.0),
      child: FlatButton(
        onPressed: () {
          if (text.contains("B")) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AppointmentPage(
                        stylistId:
                            "${snapshot.data.documents[index].data["email"]}",
                        stylistName:
                            "${snapshot.data.documents[index].data["fullname"]}",
                      )),
            );
          }
        },
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
      ),
    );
  }
}

Widget starReview() {
  return Container(
    child: Icon(
      Icons.favorite,
      color: Colors.purple,
      size: 14.0,
    ),
  );
}
