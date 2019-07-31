import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import './home.dart';
import './stylist.dart';
import './signup.dart';
import './crud.dart';
import './confirm.dart';
import './drawer.dart';

bool submitted = false;

class AppointmentPage extends StatefulWidget {
  final String stylistId;
  const AppointmentPage({Key key, this.stylistId}) : super(key: key);
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final key3 = new GlobalKey<FormState>();
  CRUDMethods crudObject = new CRUDMethods();
  DateTime currentDate = new DateTime.now();
  TimeOfDay currentTime = new TimeOfDay.now();
  var services = ["Home service", "Go to stylist"];
  var styles = [
    "Box braids",
    "Twisted braids",
    "Bob braids",
    "Crochet",
    "Corn Rows"
  ];
  String selectedService;
  String selectedStyle;

  updateSubmitted() {
    setState(() {
      submitted = true;
    });
  }

  void serviceSelected(String currentSelected) {
    setState(() {
      this.selectedService = currentSelected;
    });
  }

  void styleSelected(String currentSelected) {
    setState(() {
      this.selectedStyle = currentSelected;
    });
  }

  Future selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
        context: context,
        initialDate: currentDate,
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
    if (selected != null && selected != currentDate) {
      setState(() {
        currentDate = selected;
      });
    }
  }

  Future selectTime() async {
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
      if (picked != currentTime) {
        currentTime = picked;
      }else{
        return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          drawer: DrawerPage(),
          appBar: AppBar(
            backgroundColor: Colors.purple,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StylistPage()),
                );
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Appointment",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.white),
            ),
            centerTitle: true,
            actions: <Widget>[],
          ),
          body: ListView(
            children: <Widget>[
              bookingForm(),
            ],
          )),
    );
  }

  Widget bookingForm() {
    return Form(
        key: key3,
        child: Column(
          children: <Widget>[
            dateField(),
            timeField(),
            Card(
              child: Column(
                children: <Widget>[
                  styleField(),
                  serviceField(),
                ],
              ),
            ),
            submitField(),
          ],
        ));
  }

  Widget dateField() {
    return Container(
      width: 300.0,
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
              child: Text(new DateFormat.yMMMd().format(currentDate)),
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
                          "Choose Date",
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

  Widget timeField() {
    return Container(
      width: 300.0,
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
              child: Text(currentTime.toString()),
            ),
            Container(
              width: 180.0,
              height: 40.0,
              margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: RaisedButton(
                color: Colors.purple,
                onPressed: () {
                  selectTime();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Choose Time",
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

  Widget styleField() {
    return Container(
      width: 300.0,
      height: 50.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.purple,
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            hintText: "Choose Style",
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
            border: InputBorder.none),
        items: styles.map((String dropdownStringItem) {
          return DropdownMenuItem<String>(
            value: dropdownStringItem,
            child: Center(
              child: Text(dropdownStringItem),
            ),
          );
        }).toList(),
        onChanged: (String currentSelected) {
          styleSelected(currentSelected);
        },
        value: selectedStyle,
        validator: validatename,
      ),
    );
  }

  Widget serviceField() {
    return Container(
      width: 300.0,
      height: 50.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.purple,
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            hintText: "Choose Service type",
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
            border: InputBorder.none),
        items: services.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Center(
              child: Text(dropDownStringItem),
            ),
          );
        }).toList(),
        onChanged: (String currentSelected) {
          serviceSelected(currentSelected);
        },
        value: selectedService,
        validator: validatename,
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
          if (key3.currentState.validate()) {
            updateSubmitted();
            key3.currentState.save();
            if (submitted) {
              createAppointment();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfirmPage()),
              );
            } else {
              return null;
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

  createAppointment() async {
    var auth = await FirebaseAuth.instance.currentUser();
    String uid = auth.uid;
    crudObject
        .addAppointment(
            DateTime.now(),
            currentDate.toString(),
            "incomplete",
            currentTime.toString(),
            uid,
            widget.stylistId,
            selectedStyle,
            selectedService)
        .catchError((e) {
      print(e.toString());
    });
  }
}
