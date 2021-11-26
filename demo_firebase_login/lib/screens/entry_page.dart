import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import 'login_page.dart';
import 'main.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Align(
          alignment: const AlignmentDirectional(0, -0.3),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 200,
                height: 200,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/happy_mV2.png',
                  fit: BoxFit.contain,
                ),
              ),
              const Spacer(flex: 3),
              const Text(
                'Welcome ',
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: Colors.black,
                  fontSize: 44,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Spacer(flex: 9),
              getMyDivider(),
              const Spacer(),
              SizedBox(
                width: 300,
                height: 40,
                child: ElevatedButton.icon(
                  onPressed:(){
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration:const Duration(milliseconds: 300),
                        reverseDuration:const Duration(milliseconds: 300),
                        child: LogInPage(typeOfUser:TypeOfUser.user),
                      ),
                    );
                  },
                  icon:const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  style: myButtonStyle,
                  label:
                  Text('User', style: labelStyleForButton),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 300,
                height: 40,
                child: ElevatedButton.icon(
                  onPressed:(){
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration:const Duration(milliseconds: 300),
                        reverseDuration:const Duration(milliseconds: 300),
                        child: LogInPage(typeOfUser:TypeOfUser.expert),
                      ),
                    );
                  },
                  icon:const FaIcon(
                    FontAwesomeIcons.university,
                    color: Colors.black,
                  ),
                  style: myButtonStyle,
                  label:
                  Text('Professional', style: labelStyleForButton),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );

  }
}
