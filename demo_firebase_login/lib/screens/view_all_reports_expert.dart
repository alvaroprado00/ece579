import 'package:demo_firebase_login/components/report_card.dart';
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
  /* TODO  ADD a filter bar by category */
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String dropDownValue ="bullying";

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [DropdownButton(
                  value: dropDownValue,
                  items: <String>['bullying',
                    'child abuse',
                    'suicide',
                    'nutrition']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),

                  onChanged: (String? newValue) {
                    setState(() {
                      dropDownValue = newValue!;
                    });
                  },
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: myDropDownButtonStyle,
              )],
                ),GetReportCardExpert()
              ]
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

