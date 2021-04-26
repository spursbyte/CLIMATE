
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'auth.dart';

class DatabaseMethods with ChangeNotifier {

  String initUserEmail, initName, initUserId, initComplaintPost, initForumPost;
  String get getInitUserName => initName;
  String get getInitUserEmail => initUserEmail;
  String get getInitUserId => initUserId;
  String get getInitComplaintPost => initComplaintPost;
  String get getInitForumPost => initForumPost;


  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

  Future createComplaintCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection("Complaints")
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

  Future createForumCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection("Forum")
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

  Future initUserData(BuildContext context) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .get()
        .then((doc) {
      initUserEmail = doc.data()["email"];
      initUserId = doc.data()["userid"];
      initName = doc.data()["name"];
      notifyListeners();
    } );
  }

  static UploadTask uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  // static UploadTask uploadBytes(String destination, Uint8List data) {
  //   try {
  //     final ref = FirebaseStorage.instance.ref(destination);
  //
  //     return ref.putData(data);
  //   } on FirebaseException catch (e) {
  //     return null;
  //   }
  // }

}