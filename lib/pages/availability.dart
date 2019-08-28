import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import './slot.dart';
import './stylist.dart';

class AvailablePage extends StatefulWidget {
  final String stylistId;
  const AvailablePage({Key key, this.stylistId,}) : super(key: key);
  @override
  _AvailablePageState createState() => _AvailablePageState();
}

class _AvailablePageState extends State<AvailablePage> {
  final key4 = new GlobalKey<FormState>();
  DateTime date;
  TimeOfDay startTime;
  TimeOfDay endTime;

  Future selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(3000),
        builder: (BuildContext context, Widget child) {
          return FittedBox(
            child: Theme(
              data: ThemeData(primaryColor: Colors.purple),
              child: child,
            ),
          );
        });

    setState(() {
      date = selected;
    });
  }

  Future selectStartTime() async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return FittedBox(
          child: Theme(
            data: ThemeData(primaryColor: Colors.purple),
            child: child,
          ),
        );
      },
    );
    setState(() {
      startTime = picked;
    });
  }

  Future selectEndTime() async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return FittedBox(
          child: Theme(
            data: ThemeData(primaryColor: Colors.purple),
            child: child,
          ),
        );
      },
    );
    setState(() {
      endTime = pickedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StylistPage()),
            );
          },
        ),
        title: Text(
          "Available slots",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ), 
      body: availableSlots(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SlotPage(stylistId: widget.stylistId,)),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.purple,
      ),
    );
  }

  availableSlots() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("slots")
          .where(
            "stylistId",
            isEqualTo: "Thgjssssshsjdh",
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10.0),
                height: 150.0,
                child: Card(
                  child: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child: Text(
                              " Date: ${snapshot.data.documents[index].data["date"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              " From: ${snapshot.data.documents[index].data["start_time"]} - ${snapshot.data.documents[index].data["end_time"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.purple),
                          child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Book",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              )),
                        ),
                      )
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
}
