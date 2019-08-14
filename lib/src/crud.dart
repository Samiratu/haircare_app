import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class CRUDMethods {
  final bool stylist = true;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> showAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: const Text('User with this email already exist.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        );
      },
    );
  }

  void createDataCustomer(String uid, String name, String email, String phone,
      String address, context, String category) async {
    print("called");
    DocumentReference ref = await Firestore.instance.collection('users').add({
      'uid': uid,
      'fullname': name,
      'email': email,
      'phone': phone,
      'address': address,
      'category': category,
    }).then((f) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()))
        .then((f) {}));
    print(" ref is ${ref.documentID}");
  }

  void createDataStylist(
      String uid,
      String name,
      String email,
      String phone,
      String address,
      context,
      String category,
      bool stylist,
      String imageUrl) async {
    print("called");
    DocumentReference ref = await Firestore.instance.collection('users').add({
      'uid': uid,
      'fullname': name,
      'email': email,
      'phone': phone,
      'address': address,
      'category': category,
      'stylist': true,
      'photoUrl': imageUrl,
    }).then((f) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()))
        .then((f) {}));
    print(" ref is ${ref.documentID}");
  }

  Future<FirebaseUser> createUser(
      context, String email, String password, name, phone, address,
      [String category]) async {
    FirebaseUser user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      createDataCustomer(user.uid, name.text, email, phone.text, address.text,
          context, category);
    }).then(((f){
      saveDeviceToken();
    })).catchError((er) {
      if (er.message
          .contains("The email address is already in use by another account")) {
        showAlert(context);
      }
    });
    return user;
  }

  Future<FirebaseUser> createStylist(
      context, String email, String password, name, phone, address, photoUrl,
      [String category]) async {
    FirebaseUser user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      createDataStylist(user.uid, name.text, email, phone.text, address.text,
          context, category, stylist, photoUrl);
    }).then(((f){
      saveDeviceToken();
    })).catchError((er) {
      if (er.message
          .contains("The email address is already in use by another account")) {
        showAlert(context);
      }
    });
    return user;
  }

  Future getData() async {
    var data = await Firestore.instance
        .collection("users")
        .where("stylist", isEqualTo: true)
        .getDocuments();
    return data;
  }

  Future<void> addAppointment(
      DateTime dateCreated,
      String appointmentDate,
      String appointmentStatus,
      String appointmentTime,
      String uid,
      String stylistId,
      String style,
      String service,
      String stylistName
      ) async {
    if (isLoggedIn() && uid != stylistId) {
      DocumentReference reference =
      await Firestore.instance.collection("appointment").add({
        "Date_created": dateCreated,
        "appointment_date": appointmentDate,
        "appointment_status": appointmentStatus,
        "appointment_time": appointmentTime,
        "customer_id": uid,
        "servcice_id": style,
        "service_type": service,
        "stylist_id": stylistId,
        "stylist_name":stylistName
      });
    } else {
      return null;
    }
  }

  saveDeviceToken() async {
//    get current user
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;
//  get token from the device
    String fcmToken = await firebaseMessaging.getToken();
    if (fcmToken != null) {
      var tokenRef = Firestore.instance.collection('users')
          .document(uid)
          .collection('tokens')
          .document(fcmToken);
      await tokenRef.setData({'token':fcmToken,
        'createdOn': FieldValue.serverTimestamp(),
      });
    }
  }
}