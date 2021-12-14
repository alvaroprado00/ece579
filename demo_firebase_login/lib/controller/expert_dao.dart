import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase_login/config/config_data.dart';
import 'package:demo_firebase_login/controller/diploma_dao.dart';
import 'package:demo_firebase_login/controller/auth_dao.dart';
import 'package:demo_firebase_login/model/expert.dart';
import 'package:demo_firebase_login/screens/util_logic.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> addExpert({required Expert e, required String password,}) async {
  //First we upload the user in Auth DB

  try {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: e.email,
      password: password,
    ).then((value){
         return addExpertToFireStore(expert: e, userId: value.user!.uid);
        }).catchError((e){return e.toString();});

    //If we succeed in creating the expert in the Auth DB, then we create the entry for the other info in the separate collection


  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return'The account already exists for that email.';
    } else{
      return 'Another error';
    }
  } catch (e) {
    return e.toString();
  }

}

Future<String> addExpertToFireStore(
    {required Expert expert, required String userId}) {
  // Call the user's CollectionReference
  CollectionReference experts =
      FirebaseFirestore.instance.collection(expertCollectionName);

  //Access specific entry and set info
  return experts.doc(userId).set({
    'userName': expert.userName,
    'email': expert.email,
    'phoneNumber': expert.phoneNumber,
    'phoneNumberPrefix': expert.phoneNumberPrefix,
    'expertise': expert.expertise.toString(),
    'description': expert.description,
    'diplomaUrl': expert.diplomaUrl,
  }).then((value) {
    print('EXPERT CREATED');
    addDiplomaToStorage(expert.diplomaUrl);
    return "Expert Created";
    //I indicate the expert has been created and call function to upload the image to storage

  }).catchError((error) {print("ERROR when persisting expert in collection"); return "Error when persisting in Firestore";});
}

Future<DocumentSnapshot<Object?>> getActiveExpert({required String uid}) {
  // Call the user's CollectionReference
  CollectionReference cr =
      FirebaseFirestore.instance.collection(expertCollectionName);

  return cr.doc(uid).get();
}

/*
 Even the functions from th expert and the user are nearly the same, I prefer to keep them separated in case something
 changes in the future
 */

Future<String> updateUserNameForExpert({required String value}) {
  CollectionReference users =
      FirebaseFirestore.instance.collection(expertCollectionName);

  //I can get the uid of the active user with the following method

  String uidOfActiveExpert = FirebaseAuth.instance.currentUser!.uid;

  //I access to the document with name equal the expert id so I can update the user name

  return users.doc(uidOfActiveExpert).update({'userName': value}).then((value) {
    return "User Updated";
  }).catchError((error) {
    return "Failed to update user: $error";
  });
}

Future<String> updateEmailForExpert({required String value}) {
  //Reference to the experts collection
  CollectionReference users =
      FirebaseFirestore.instance.collection(expertCollectionName);

  //Id of the current expert
  String uidOfActiveExpert = FirebaseAuth.instance.currentUser!.uid;

  return users
      .doc(uidOfActiveExpert)
      .update({'email': value}).then((val) async {
    //Once we have updated the name of the user in the Firestore Doc, we update it in Auth DB
    await updateEmailAuthDb(value).then((val) {
      if (!val) {
        return ('Expert email not updated in Auth Db');
      }
    });
    return "User Email Updated";
  }).catchError((error) {
    return "Failed to update expert email in Firestore";
  });
}

Future<String> updatePhoneForExpert({required String value}) {
  //Reference to the experts collection
  CollectionReference users =
      FirebaseFirestore.instance.collection(expertCollectionName);

  //Id of the current expert
  String uidOfActiveExpert = FirebaseAuth.instance.currentUser!.uid;

  return users.doc(uidOfActiveExpert).update({'phoneNumber': value}).then((val) {
    return "User Phone Updated";
  }).catchError((error) {
    return "Failed to update expert phone in Firestore";
  });
}

Future<String> updatePrefixForExpert({required String value}){
  //Reference to the experts collection
  CollectionReference users =
  FirebaseFirestore.instance.collection(expertCollectionName);

  //Id of the current expert
  String uidOfActiveExpert = FirebaseAuth.instance.currentUser!.uid;

  return users.doc(uidOfActiveExpert).update({'phoneNumberPrefix': phonePrefixToInt(value)}).then((val) {
    return "Prefix Updated";
  }).catchError((error) {
    return "Failed to update prefix field";
  });
}

Future<String> saveReportExpertList({required List<String> expertToSaveID, required String reportID}){
  CollectionReference reports = FirebaseFirestore.instance.collection('reports');
  print('Im called');
  return reports.doc(reportID).update({'reportSavedBy' : FieldValue.arrayUnion(expertToSaveID)})
      .then((value) {
    return "Report added to expert list";
  }).catchError((error){
    return "Could not save the report to the expert list";
  });
}