import 'package:flutter/material.dart';
import './drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicePage extends StatefulWidget {
  @override
  createState() {
    return ServicePageState();
  }
}

class ServicePageState extends State<ServicePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerPage(),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.purple,
            ),
          ),
          backgroundColor: Colors.white,
          title: Text("Services", style: TextStyle(color: Colors.black)),
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
        body: services(),
      ),
    );
  }

  services() {
    return StreamBuilder(
      stream: Firestore.instance.collection("services").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return Card(
                child: Stack(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.network(
                      "${snapshot.data.documents[index].data["image"]}",
                      fit: BoxFit.fill,
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child:
                      Container(
                        width: 140.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0))
                        ),
                        margin: EdgeInsets.only(top: 80.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "${snapshot.data.documents[index].data["service_name"]}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${snapshot.data.documents[index].data["service_price"]} RWF",
                                style: TextStyle(
                                    fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}

// function to create tap bar.Padding
createTapbar() {
  return Container(
    color: Colors.purple,
    height: 40.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: FlatButton(
              onPressed: () {},
              child: Text(
                "Home",
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              )),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
          child: FlatButton(
              onPressed: null,
              child: Text(
                "Stylits",
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              )),
        ),
        Container(
          child: FlatButton(
              onPressed: null,
              child: Text(
                "Services",
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              )),
        )
      ],
    ),
  );
}

// function to create a service
serviceDetails() {
  return Card(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Image.asset(
            'images/braids.jpg',
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  "Box braids",
                  style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple),
                ),
              ),
              Container(
                child: Text(
                  " Price : RWF 7000",
                  style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Text(
                  "Duration : 4 hours",
                  style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}