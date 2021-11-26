import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase_login/config/config_data.dart';
import 'package:demo_firebase_login/model/user_custom.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_dao.dart';

Future<void> addUser({required UserCustom u, required String password}) async {
  //First we upload the user in Auth DB

  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: u.email,
      password: password,
    );

    //If we succeed in creating the user in the Auth DB, then we create the entry for the other info in the separate collection

    addUserToFireStore(userCustom: u, userId: userCredential.user!.uid);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

Future<void> addUserToFireStore(
    {required UserCustom userCustom, required String userId}) {
  // Call the user's CollectionReference
  CollectionReference users =
      FirebaseFirestore.instance.collection(userCollectionName);

  //Access specific entry and set info
  return users
      .doc(userId)
      .set({
        'userName': userCustom.userName,
        'email': userCustom.email,
      })
      .then(
        (value) => print("USER CREATED"),
      )
      .catchError((error) => print("ERROR when persisting user in collection"));
}

Future<bool> isUser({required String uid}) {
  // Call the user's CollectionReference
  var docRef =
      FirebaseFirestore.instance.collection(userCollectionName).doc(uid);

  return docRef.get().then((doc) {
    if (doc.exists) {
      return true;
    } else {
      return false;
    }
  });
}

Future<DocumentSnapshot<Object?>> getActiveUser({required String uid}) {
  // Call the user's CollectionReference

  CollectionReference cr =
      FirebaseFirestore.instance.collection(userCollectionName);

  return cr.doc(uid).get();
}

Future<String> updateUserNameForUser({required String value}) {
  CollectionReference users =
      FirebaseFirestore.instance.collection(userCollectionName);

  //I can get the uid of the active user with the following method

  String uidOfActiveUser = FirebaseAuth.instance.currentUser!.uid;

  return users.doc(uidOfActiveUser).update({'userName': value}).then((value) {
    return "User Updated";
  }).catchError((error) {
    return "Failed to update user: $error";
  });
}

Future<String> updateEmailForUser({required String value}) {
  CollectionReference users =
      FirebaseFirestore.instance.collection(userCollectionName);

  //I can get the uid of the active user with the following method

  String uidOfActiveUser = FirebaseAuth.instance.currentUser!.uid;

  return users.doc(uidOfActiveUser).update({'email': value}).then((val) async {
    //Once we have updated the name of the user in firestore, we update it in Auth DB
    await updateEmailAuthDb(value).then((val) {
      if (val) {
        print('User email updated in Auth DB');
      } else {
        print('User email NOT updated in Auth DB');
      }
    });
    return "User Email Updated";
  }).catchError((error) {
    return "Failed to update user in firestore";
  });
}