import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import './stylist.dart';

class AvailablePage extends StatefulWidget {
  final String stylistId;
  const AvailablePage({Key key, this.stylistId,}) : super(key: key);
  @override
  _AvailablePageState createState() => _AvailablePageState();
}

class _AvailablePageState extends State<AvailablePage> {
  final formatDate = DateFormat("yyyy-MM-dd");
  final formatTime = DateFormat("HH:mm");
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
          addSlot();
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
          .collection("availability")
          .where(
            "stylist_id",
            isEqualTo: "Tusnjassgask",
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
                              ""
                              " Date: ${snapshot.data.documents[index].data["availabe_date"]}",
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
//                          color: Colors.purple,
                          child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                "Book",
                                style: TextStyle(
//                                  color: Colors.white,
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

  Widget dateField() {
    return Container(
      width: 200.0,
      height: 130.0,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.purple, width: 1.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: date == null ? Text("?") : Text(new DateFormat.yMMMd().format(date)),
            ),
            Container(
                width: 180.0,
                height: 40.0,
                margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: RaisedButton(
                    color: Colors.purple,
                    onPressed: () {
                      selectDate(context);
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Select Date",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  Widget startTimeField() {
    return Container(
      width: 200.0,
      height: 130.0,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.purple, width: 1.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(15.0),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: startTime == null?Text("?"): Text(TimeOfDay(hour: startTime.hour, minute: startTime.minute).toString()),
            ),
            Container(
              width: 180.0,
              height: 40.0,
              margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: RaisedButton(
                color: Colors.purple,
                onPressed: () {
                  selectStartTime();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Start Time",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.watch_later,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget endTimeField() {
    return Container(
      width: 200.0,
      height: 130.0,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.purple, width: 1.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(15.0),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: endTime == null?Text("?"): Text(TimeOfDay(hour: endTime.hour, minute: endTime.minute).toString()),
            ),
            Container(
              width: 180.0,
              height: 40.0,
              margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: RaisedButton(
                color: Colors.purple,
                onPressed: () {
                  selectEndTime();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "End Time",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.watch_later,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  void addSlot() async{
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add available time"),
          content: ListView(
            children: <Widget>[
              Form(child: Column(
                children: <Widget>[
                  dateField(),
                  startTimeField(),
                  endTimeField(),
                ],
              ))
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }
}
