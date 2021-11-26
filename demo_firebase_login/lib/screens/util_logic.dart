import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';


//Function to show an alert dialog when user tries to log in with wrong credentials

showAlertDialog({required BuildContext context, required String error} ) {

  // Set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pop(context);

    },
  );

  // Set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Something went wrong"),
    content: Text(error.substring(error.indexOf(']')+1)),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String? validatorForPhone(String? val){
  if (val!.isEmpty) {
    return 'Field is required';
  }else if(int.tryParse(val) == null){
    return 'Field should be a number';
  }else if(val.length<9){

    return 'You are missing digits';
  }else{
    return null;
  }
}

String? validatorForNotEmpty(String? val){
  if (val==null|| val.isEmpty) {
    return 'Field is required';
  }else{
    return null;
  }
}

String? validatorForEmail(String? val){
  if (val==null|| val.isEmpty) {
    return 'Field is required';
  }else if(!EmailValidator.validate(val)){
    return 'Please use a valid email';
  }else{
    return null;
  }
}
String? validatorForPassword(String? val) {
  if (val == null || val.isEmpty) {
    return 'Field is required';
  }
  if (val.length < 6) {
    return 'Password should have 6 characters';
  } else {
    return null;
  }
}


  int phonePrefixToInt(String stringValue){
    String prefixString=stringValue;
    int indexOfPlus= prefixString.indexOf('+', 0);

    //Update prefixString to get only number

    prefixString= prefixString.substring(indexOfPlus+1);

    return int.parse(prefixString);
  }