import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase_login/config/config_data.dart';
import 'package:demo_firebase_login/controller/diploma_dao.dart';
import 'package:demo_firebase_login/model/expert.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<void> addExpert({required Expert e, required String password}) async {

  //First we upload the user in Auth DB

  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: e.email,
      password: password,
    );

    //If we succeed in creating the expert in the Auth DB, then we create the entry for the other info in the separate collection

   addExpertToFireStore(expert: e, userId: userCredential.user!.uid);

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

Future<void> addExpertToFireStore({required Expert expert, required String userId}){

  // Call the user's CollectionReference
  CollectionReference experts = FirebaseFirestore.instance.collection(expertCollectionName);

  //Access specific entry and set info
  return experts.doc(userId).set({
    'userName': expert.userName,
    'email':expert.email,
    'phoneNumber': expert.phoneNumber,
    'phoneNumberPrefix': expert.phoneNumberPrefix,
    'expertise':expert.expertise.toString(),
    'description': expert.description,
    'diplomaUrl': expert.diplomaUrl,
  })
      .then((value){
        print('EXPERT CREATED');
        //I indicate the expert has been created and call function to upload the image to storage
        addDiplomaToStorage(expert.diplomaUrl);

  })
      .catchError((error)=> print("ERROR when persisting expert in collection"));
}