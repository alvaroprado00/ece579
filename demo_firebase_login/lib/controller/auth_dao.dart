//All of the following functions are valid for both user and expert since they refer to the user in the Auth DB

import 'package:firebase_auth/firebase_auth.dart';

/*
*  This file.dart has all the necessary methods to do any action on the active user in the Auth DB
*
*  Notice that the active user in the Auth Db is only identified by an email and a password
*
*  That 'user' could be either one of our UserCustom or an Expert
*
 */

Future<bool> updateEmailAuthDb(String newEmail) async{

  return FirebaseAuth.instance.currentUser!.updateEmail(newEmail).then((val){
    return true;
  }).catchError((e){return false;});

}

Future<String> updatePasswordAuthDb({required String value}) async{

  // The password is just a thing to be changed in the DB of auth

  final user = FirebaseAuth.instance.currentUser!;

  //Pass in the password to updatePassword.
  return user.updatePassword(value).then((_){
    return "Successfully changed password";

  }).catchError((error){
    return ("Password can't be changed" + error.toString());

    //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
  });
}

Future <String> deleteUserAccount(){
  final user = FirebaseAuth.instance.currentUser!;
  return user.delete().then((_){
    return 'User deleted';

  }).catchError((err){
    return 'User can\'t be deleted. You need to be recently signed in';
  });
}

void signOut(){
  FirebaseAuth.instance.signOut();

}