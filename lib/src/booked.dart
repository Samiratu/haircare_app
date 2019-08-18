import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'crud.dart';

class BookedPage extends StatefulWidget {
  @override
  createState() {
    return BookedPageState();
  }
}

class BookedPageState extends State<BookedPage> {
  String userEmail;
  QuerySnapshot appoints;
  CRUDMethods crudObject = new CRUDMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      FirebaseAuth.instance.currentUser().then((user){
//        print(user.email);
       setState(() {
         userEmail = user.email;
       });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "My Appointment",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: bookedTime(),
    );
  }

  bookedTime() {
//    print("name");
  print(userEmail);
    return userEmail!=null? StreamBuilder(
      stream:Firestore.instance.collection("appointment").where("customer_email", isEqualTo: userEmail).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              return Container(
                margin: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 500.0,
                      width: 370.0,
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              child: ListTile(
                                leading: Icon(
                                  Icons.date_range,
                                  color: Colors.purple,
                                  size: 30,
                                ),
                                title: Text("${snapshot.data.documents[index].data["appointment_date"]}"),
                              ),
                            ),
                            Container(
                              child: ListTile(
                                leading: Icon(
                                  Icons.access_time,
                                  color: Colors.purple,
                                  size: 30,
                                ),
                                title: Text("${snapshot.data.documents[index].data["appointment_time"]}"),
                              ),
                            ),
                            Container(
                              child: ListTile(
                                leading: Text(
                                  "Stylist",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                title: Text("${snapshot.data.documents[index].data["stylist_name"]}"),
                              ),
                            ),
                            Container(
                              child: ListTile(
                                leading: Text(
                                  "Service",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                title: Text("Home service"),
                              ),
                            ),
                            Container(
                              child: ListTile(
                                leading: Text(
                                  "Status",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                title: Text("${snapshot.data.documents[index].data["appointment_status"]}"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );

            },
          );
        }
      },
    ):Container(

    );
  }

}