import 'package:demo_firebase_login/model/user_report.dart';
import 'package:demo_firebase_login/screens/view_reportx_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GetMessageList extends StatelessWidget {
  final String reportID;

  GetMessageList(this.reportID);
  @override
  Widget build(BuildContext context) {
    CollectionReference reportMessage = FirebaseFirestore.instance.collection("reports");
    return FutureBuilder<DocumentSnapshot>(
    future: reportMessage.doc(reportID).get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if(snapshot.hasError){
        return Text("Could not load messages come bakc later");
      }
      if(snapshot.hasData && !snapshot.data!.exists){
        return Text("No message found check back later");
      }
      else {
        Map<String, dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
        return Text("to fix but cba ${data['chat']}");
      }
  },
    );
  }
}