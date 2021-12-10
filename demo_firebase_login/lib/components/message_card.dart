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
  List<String> messageList = [];


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
      if(snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
        int len = data['chat'].toString().split(",").length;
        data['chat'][0];
        for(int i=0;i<len;i++){
          messageList.add(data['chat'][i]);
        }
        print(messageList.length);
        //messageList
        return SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.only(left:10,right: 10),
            separatorBuilder: (BuildContext context, int index) => const Divider(thickness:2,color: Colors.black,),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: messageList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 20,
                color: Colors.tealAccent,
                child: Text('${messageList[index]}'),
              );
            },
          ),
        );
      }
      return Text("Loading...");
  },
    );
  }
}