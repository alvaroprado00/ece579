import 'package:demo_firebase_login/components/report_card.dart';
import 'package:demo_firebase_login/model/user_report.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewPatientReportExpert extends StatelessWidget {
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
              children: [
                GetReportCardPatientExpert(userId),
              ]
          ),
        ),
      ),
    );
  }
}
