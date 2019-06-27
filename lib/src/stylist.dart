import 'package:flutter/material.dart';
import './service.dart';
import './home.dart';

class StylistPage extends StatefulWidget {
  @override
  createState() {
    return StylistPageState();
  }
}

class StylistPageState extends State<StylistPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        elevation: 200.0,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Hammad Nadia'),
              accountEmail: Text('nadia.com@gmail.com'),
              currentAccountPicture: Image.asset('images/profile.jpg'),
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_view_day,
                color: Colors.purple,
              ),
              title: Text("My Bookings"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.shop,
                color: Colors.purple,
              ),
              title: Text("Buy hair products"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.purple,
              ),
              title: Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.purple,
              ),
              title: Text("About"),
              onTap: () {},
            ),
          ],
        ),
      ),
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
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
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
                        onPressed: null,
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
                            MaterialPageRoute(
                                builder: (context) => ServicePage()),
                          );
                        },
                        child: Text(
                          "Services",
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        )),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                createProfile(),
                createProfile(),
                createProfile(),
                createProfile(),
                createProfile(),
              ],
            )
          ],
        ),
      ),
    ));
  }

  List<dynamic> generateListItems() {
    var item = createProfile();
    var listItems = [];
    for (int i = 0; i < 10; i++) {
      listItems.add(item);
    }
    return listItems;
  }

  createProfile() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 20.0),
                    height: 120.0,
                    child: Image.asset('images/profile.jpg'),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Mary James",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Braids Stylist",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          ),
                        ),
                        Container(
                          child: Text(
                            "+237677204981",
                            style: TextStyle(
                              fontSize: 11.0,
                            ),
                          ),
                        ),
                        Container(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.message,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                            Container(
                              // padding:EdgeInsets.all(10.0),
                              child: Text(
                                "Send message",
                                style: TextStyle(fontSize: 9.0),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Reviews"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.star_border,
                          size: 16.0,
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.star_border,
                          size: 16.0,
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.star_border,
                          size: 16.0,
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.star_border,
                          size: 16.0,
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.star_border,
                          size: 16.0,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 90.0,
                    margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 5.0),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Colors.purple,
                      child: Text(
                        "See Album",
                        style: TextStyle(fontSize: 10.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Divider(
            height: 20.0,
            // color: Colors.purple,
          ),
        ],
      ),
    );
  }
}
