import 'package:flutter/material.dart';
import './service.dart';
import './stylist.dart';

class HomePage extends StatefulWidget {

  createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        key: _scaffoldKey,
        drawer: appDrawer(context),
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
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                          child: Text(
                            "Home",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                      child: FlatButton(
                          onPressed: () {
                            print("clicked");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StylistPage()),
                            );
                          },
                          child: Text(
                            "Stylits",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          )),
                    )
                  ],
                ),
              ),
              Container(
                height: 130.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/showcase.jpg'),
                        fit: BoxFit.cover),
                    border: Border.all(
                        color: Colors.purple,
                        width: 2.0,
                        style: BorderStyle.solid)),
                child: Align(
                  child: Text(
                    "Discount at 30%",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.purple),
                  ),
                ),
              ),
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
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            "Weavon",
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
                        child: Container(
                          padding: EdgeInsets.all(3.0),
                          margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                          child: Text(
                            " ",
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
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                child: Align(
                  child: Text(
                    "BOOK NOW",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.purple,
                            width: 2.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: EdgeInsets.all(5.0),
                      child: FlatButton(
                        onPressed: () {},
                        child: Text("Home services"),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.purple,
                            width: 2.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: EdgeInsets.all(5.0),
                      child: FlatButton(
                        onPressed: () {},
                        child: Text("Slot at saloon"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.purple,
                      width: 2.0,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.all(5.0),
                child: FlatButton(
                  onPressed: () {},
                  child: Text("Buy Hair Products"),
                ),
              )
            ],
          ),
        ),
      
    );
  }
}

Widget appDrawer(context){
  return Drawer(
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage()),
            );
          },
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
  );
}
