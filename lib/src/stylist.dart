import 'package:flutter/material.dart';
import './home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './crud.dart';
import './appointment.dart';
import './drawer.dart';

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
          body: stylistProfile(),
        ));
  }

  Widget stylistProfile() {
    if (stylists != null) {
      return ListView.builder(
          itemCount: stylists.documents.length,
          itemBuilder: (context, i) {
            return Card(
              margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                                radius: 60.0,
                                backgroundColor: Colors.purple,
                                child: ClipOval(
                                  child: SizedBox(
                                    width: 113.0,
                                    height: 113.0,
                                    child: (stylists.documents[i]
                                                .data["photoUrl"] !=
                                            null)
                                        ? Image.network(
                                            "${stylists.documents[i].data["photoUrl"]}",
                                            fit: BoxFit.fill,
                                          )
                                        : Image.asset('images/profile.jpg',
                                            fit: BoxFit.fill),
                                  ),
                                )),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "${stylists.documents[i].data["fullname"]}",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      "${stylists.documents[i].data["category"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "${stylists.documents[i].data["address"]}",
                                      style: TextStyle(
                                        fontSize: 11.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 6.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Padding(
                                          padding: EdgeInsets.all(1.0),
                                          child: RaisedButton(
                                            color: Colors.purple,
                                            child: Text(
                                              "Book Stylist",
                                              style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AppointmentPage(
                                                          stylistId: stylists
                                                              .documents[i]
                                                              .data["uid"],
                                                        )),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                          style: BorderStyle.solid)),
                                  child: FlatButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Edit review",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  starReview(),
                                  starReview(),
                                  starReview(),
                                  starReview(),
                                  starReview(),
                                ],
                              ),
                              Container(
                                width: 83.0,
                                margin:
                                    EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 5.0),
                                child: RaisedButton(
                                  onPressed: () {},
                                  color: Colors.purple,
                                  child: Text(
                                    "See Album",
                                    style: TextStyle(
                                        fontSize: 10.0, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      return LinearProgressIndicator();
    }
  }
}

Widget starReview() {
  return Container(
    child: Icon(
      Icons.star_border,
      size: 13.0,
    ),
  );
}
