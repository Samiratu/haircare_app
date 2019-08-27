import 'package:flutter/material.dart';
import './stylist.dart';

class StylistImage extends StatelessWidget {
  final String imageUrl;
  const StylistImage({Key key, this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => StylistPage()),
              );
            }),
      ),
      body: Container(
        color: Colors.white,
        width: 300.0,
        height: 450.0,
        margin: EdgeInsets.all(10.0),
        child: Image.network(
          "$imageUrl",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
