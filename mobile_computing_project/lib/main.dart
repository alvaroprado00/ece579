import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_computing_project/util.dart';
import 'package:page_transition/page_transition.dart';

import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {
  //const HomePage({Key? key}) : super(key: key);

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
                  'lib/assets/images/happy_mV2.png',
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
              const Divider(
                height: 10,
                thickness: 1,
                indent: 10,
                endIndent: 10,
                color: Colors.black,
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
                        child: LogInPage(user:true),
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
                        child: LogInPage(user:false),
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
