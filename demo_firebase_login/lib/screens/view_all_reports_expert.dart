import 'package:demo_firebase_login/components/report_card.dart';
import 'package:demo_firebase_login/components/report_card_expert.dart';
import 'package:demo_firebase_login/model/user_report.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ViewAllReportsExpert extends StatefulWidget {
  //ViewReportUser({Key key}) : super(key: key);

  @override
  _ViewAllReportsExpert createState() => _ViewAllReportsExpert();
}

class _ViewAllReportsExpert extends State<ViewAllReportsExpert> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: getCustomAppBar(text: ("Report list")),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: const BoxDecoration(
            color: Color(0x00ffffff),
          ),
          child: ListView(
              children: [GetReportCardExpert()]
          ),
        ),
      ),
    );
  }
}

/*
getUserDoc() {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user = _auth.currentUser!;
  return user;

  in the column add
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
 */

