import 'package:flutter/material.dart';
import './home.dart';

class ConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Confirmation",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 450.0,
            margin: EdgeInsets.all(16.0),
            color: Colors.white12,
            child: Card(
              child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  logoSection(),
                  Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 60.0,
                        ),
                        Container(
                          child: Text(
                            "Congrats!!.",
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(15.0),
                          child: Text(
                            "Your appointment has been Scheduled",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 70.0,
                  ),
                  Container(
                    width: 250.0,
                    child: Text(
                      "You will recieve confirmation from the stylist shortly.",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 130.0,
                    height: 60.0,
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                    child: RaisedButton(
                      color: Colors.purple,
                      elevation: 20.0,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Home",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget logoSection() {
    return Container(
        width: 300.0,
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                "BEAUTY AT YOUR FINGER TIPS",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    wordSpacing: 5.0,
                    letterSpacing: 3.0),
              ),
            ),
          ],
        ));
  }
}
