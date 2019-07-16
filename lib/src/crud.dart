import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDMethods {


  Future<void> addData(stylistData) async {
     DocumentReference ref = await Firestore.instance.collection('stylists').add(stylistData).catchError((e){
       print(e.toString());
     });

  }

  getData()async {
    return Firestore.instance.collection("stylists").getDocuments();
  }

  Future<FirebaseUser> createStylist(stylistData,email, password) async {
    FirebaseUser user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      addData(stylistData);
    }).catchError((er) {
     print(er.toString());
    });
    return user;
  }
}
