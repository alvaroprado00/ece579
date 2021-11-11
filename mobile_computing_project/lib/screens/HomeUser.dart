import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_computing_project/screens/CreateReportUser.dart';
import 'package:mobile_computing_project/screens/ViewReportUser.dart';
import 'package:mobile_computing_project/util.dart';
import 'package:page_transition/page_transition.dart';

class HomeUser extends StatefulWidget {
  //HomeUser({Key key}) : super(key: key);

  @override
  _HomeUserState createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF94F9E1),
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: (){
              print("go to profile page");
            },
          )
        ],
        centerTitle: true,
        elevation: 4,
        title: Text('Welcome to dashboard',style: appBarTextStyle,),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                child: ElevatedButton.icon(
                  onPressed:(){
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration:const Duration(milliseconds: 300),
                        reverseDuration:const Duration(milliseconds: 300),
                        child: ViewReportUser(),
                      ),
                    );
                  },
                  icon:const Icon(
                    Icons.navigate_next,
                    size: 15,
                    color: Colors.black,
                  ),
                  style: myButtonStyle,
                  label:
                  Text('View report list', style: labelStyleForButton),
                ),
              ),
              ElevatedButton.icon(
                onPressed:(){
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration:const Duration(milliseconds: 300),
                      reverseDuration:const Duration(milliseconds: 300),
                      child: CreateReportUser(),
                    ),
                  );
                },
                icon:const Icon(
                  Icons.navigate_next,
                  size: 15,
                  color: Colors.black,
                ),
                style: myButtonStyle,
                label:
                Text('Create report', style: labelStyleForButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
