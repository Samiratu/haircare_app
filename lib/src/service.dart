import 'package:flutter/material.dart';
import './drawer.dart';

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
        body: OrientationBuilder(builder: (context, orientation) {
          createTapbar();
          return GridView.count(
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            children: <Widget>[
              serviceDetails(),
              serviceDetails(),
              serviceDetails(),
              serviceDetails(),
              serviceDetails(),
              serviceDetails(),
              serviceDetails(),
              serviceDetails(),
            ],
          );
        }),
      ),
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
              onPressed: (){},
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
