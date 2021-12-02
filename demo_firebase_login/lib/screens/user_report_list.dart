import 'package:demo_firebase_login/components/report_card.dart';
import 'package:demo_firebase_login/model/user_report.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:page_transition/page_transition.dart';



class ViewReportUser extends StatefulWidget {
  //ViewReportUser({Key key}) : super(key: key);

  @override
  _ViewReportUserState createState() => _ViewReportUserState();
}

class _ViewReportUserState extends State<ViewReportUser> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
          decoration: BoxDecoration(
            color: const Color(0xFFFFFF),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GetReportList("4bGf5qZaapTGbCavMe3U"),
            ],
          ),
        ),
      ),
    );
  }
}

// function to fetch report in firestore
