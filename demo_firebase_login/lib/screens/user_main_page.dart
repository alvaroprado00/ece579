import 'package:demo_firebase_login/screens/profile_user.dart';
import 'package:demo_firebase_login/screens/util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';


class HomeUser extends StatelessWidget {

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
                  child: EditProfileUser(),
                ),
              );
            },
          )
        ],
        centerTitle: true,
        elevation: 4,
        title: Text('Home User', style: appBarTextStyle,),
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
                'assets/lottie_animations/fly.json',
                width: 250,
                height: 200,
                fit: BoxFit.cover,
                animate: false,
                repeat: false,
              ),
              const Spacer(flex: 7),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                child: ElevatedButton(
                  onPressed: () {
                   print('poo poo');
                  },

                  style: myButtonStyle,
                  child:
                  Text('New Report', style: labelStyleForButton),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                     print('poo poo');

                },
                style: myButtonStyle,
                child:
                Text('View Reports', style: labelStyleForButton),
              ),
              const Spacer(flex: 4)
            ],
          ),
        ),
      ),
    );
  }
}
