import 'package:flutter/material.dart';
import './availability.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import './crud.dart';

class SlotPage extends StatefulWidget {
  final String stylistId;
  const SlotPage({
    Key key,
    this.stylistId,
  }) : super(key: key);
  @override
  _SlotPageState createState() => _SlotPageState();
}

class _SlotPageState extends State<SlotPage> {
  CRUDMethods _crudMethods = new CRUDMethods();
  bool submitted = false;
  bool booked = false;
  DateTime date;
  TimeOfDay startTime;
  TimeOfDay endTime;
  updateSubmitted() {
    setState(() {
      submitted = true;
    });
  }

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
        backgroundColor: Colors.purple,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AvailablePage()),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Create Slots",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: ListView(
        children: <Widget>[
          slotForm(),
        ],
      ),
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
              child: date == null
                  ? Text("?")
                  : Text(new DateFormat.yMMMd("en_US").format(date)),
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
              child: startTime == null
                  ? Text("?")
                  : Text(
                  TimeOfDay(hour: startTime.hour, minute: startTime.minute)
                      .toString()),
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
              child: endTime == null
                  ? Text("?")
                  : Text(
                  TimeOfDay(hour: endTime.hour, minute: endTime.minute)
                      .toString()),
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

  Widget submitField() {
    return Container(
      width: 150.0,
      height: 45.0,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: RaisedButton(
        color: Colors.purple,
        onPressed: () {
          if (date != null && startTime != null && endTime != null) {
            updateSubmitted();
            if (submitted) {
              _crudMethods.addSlot(date.toString(), startTime.toString(), endTime.toString(), widget.stylistId, booked);
            }else{
              print("already submitted");
            }
          }
        },
        child: Text(
          "Submit",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget slotForm() {
    return Form(
        child: Column(
          children: <Widget>[
            dateField(),
            startTimeField(),
            endTimeField(),
            submitField(),
          ],
        ));
  }
}