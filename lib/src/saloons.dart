import 'package:flutter/material.dart';
import './home.dart';
import './appointment.dart';


class SaloonsPage extends StatefulWidget {
  @override
  _SaloonsPageState createState() => _SaloonsPageState();
}

class _SaloonsPageState extends State<SaloonsPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        drawer: appDrawer(context),
        appBar: saloonAppBar(),
        body: saloonProfile(),
      ),
    );
  }

  Widget saloonProfile() {
    return ListView(
      children: <Widget>[
        saloon(),
        saloon(),
        saloon(),
      ],
    );
  }

  Widget saloon() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 210.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/saloon.jpg'), fit: BoxFit.fill),
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: 160.0,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Golden Saloon, Nija Road",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 10.0,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          button("View Details"),
                          button("Book Now"),
                        ],
                      ),
                      Container(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1.0, style: BorderStyle.solid)
                              ),
                              child: FlatButton(
                                onPressed: () {},
                                child: Text("Edit review"),
                              )),
                          saloonReview(),
                          saloonReview(),
                          saloonReview(),
                          saloonReview(),
                          saloonReview(),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button( String text){
    return Container(
      width: 100.0,
      height: 45.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.purple),
      margin: EdgeInsets.all(5.0),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AppointmentPage()),
          );

          },
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 11.0),
        ),
      ),
    );

  }

  Widget saloonAppBar() {
    return AppBar(
      backgroundColor: Colors.purple,
      leading: IconButton(
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
        icon: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      title: Text(
        "Saloons",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 19.0, color: Colors.white),
      ),
      centerTitle: true,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.all(12.0),
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
        ),
      ],
    );
  }

 Widget saloonReview() {
    return Container(
//      margin: EdgeInsets.only(top: 4.0),
      child: Icon(Icons.star, color: Colors.purple,size: 25.0,),
    );
 }

}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return null;
  }
}
