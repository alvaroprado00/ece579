import 'package:demo_firebase_login/screens/profile.dart';
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:demo_firebase_login/screens/view_all_reports_expert.dart';
import 'package:demo_firebase_login/screens/view_patient_report_expert.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:page_transition/page_transition.dart';



class HomeExpert extends StatefulWidget {
  //HomeUser({Key key}) : super(key: key);

  @override
  _HomeExpertState createState() => _HomeExpertState();
}

class _HomeExpertState extends State<HomeExpert> {
  //final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF94F9E1),
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 300),
                  reverseDuration: const Duration(milliseconds: 300),
                  child: EditProfile(),
                ),
              );
            },
          )
        ],
        centerTitle: true,
        elevation: 4,
        title: Text('Home Expert', style: appBarTextStyle,),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Align(

          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 5),
              Lottie.asset(
                'assets/lottie_animations/4452-dr-consultation.json',
                width: 350,
                height: 300,
                fit: BoxFit.cover,
                animate: true,
                repeat: false,
              ),
              const Spacer(flex: 7),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 300),
                        reverseDuration: const Duration(milliseconds: 300),
                        child: ViewAllReportsExpert(),
                      ),
                    );
                  },
                  style: myButtonStyle,
                  child:
                  Text('View all reports', style: labelStyleForButton),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 300),
                      child: ViewPatientReportExpert(),
                    ),
                  );
                },

                style: myButtonStyle,
                child:
                Text('My Patients', style: labelStyleForButton),
              ),
              const Spacer(flex: 4)
            ],
          ),
        ),
      ),
    );
  }
}
