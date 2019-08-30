import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './service.dart';
import './stylist.dart';
import './crud.dart';
import './login.dart';
import './saloons.dart';
import './drawer.dart';

class HomePage extends StatefulWidget {
  createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  CRUDMethods crudObj = new CRUDMethods();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Home",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              Icons.shopping_cart,
              color: Colors.purple,
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            header(context),
            Card(
              child: Container(
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/showcase.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Align(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                  height: 160.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        color: Colors.white54,
                        child: Text(
                          "BEAUTY AT YOUR FINGER TIPS",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.0),
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          onPressed: () {},
                          color: Colors.purple,
                          child: Text(
                            " Discounts",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                      child: Align(
                        child: Text(
                          "CATEGORIES",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      )),
                  Container(
                    height: 150.0,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: 140.0,
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              image: AssetImage('images/braids.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                "Braids",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 140.0,
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              image: AssetImage('images/crochet.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                "Crochet",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 140.0,
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              image: AssetImage('images/cornrows.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                "Cornrows",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 140.0,
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                                image: AssetImage(
                                  'images/weavon.jpg',
                                ),
                                fit: BoxFit.cover),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                "Weave",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 140.0,
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                                image: AssetImage(
                                  'images/abb.jpg',
                                ),
                                fit: BoxFit.cover),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.all(3.0),
                              margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                              child: Text(
                                "Natural",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                    child: Align(
                      child: Text(
                        "BOOK APPOINTMENT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                  ),
                  Container(
                    height: 100.0,
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          margin: EdgeInsets.all(5.0),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StylistPage()),
                              );
                            },
                            child: Text(
                              "Stylist",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.purple),
                          margin: EdgeInsets.all(5.0),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SaloonsPage()),
                              );
                            },
                            child: Text(
                              "Saloon",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                    child: Align(
                      child: Text(
                        "BUY HAIR PRODUCTS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 150.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.purple),
                    margin: EdgeInsets.all(5.0),
                    child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Shop Now",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget header(context) {
  return Container(
    color: Colors.purple,
    height: 40.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text(
                "Home",
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              )),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
          child: FlatButton(
              onPressed: () {
                print("clicked");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StylistPage()),
                );
              },
              child: Text(
                "Stylits",
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              )),
        ),
        Container(
          child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServicePage()),
                );
              },
              child: Text(
                "Services",
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              )),
        )
      ],
    ),
  );
}
