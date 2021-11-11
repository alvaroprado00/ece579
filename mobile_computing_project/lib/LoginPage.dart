import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_computing_project/signInExpert.dart';
import 'package:mobile_computing_project/SignInUser.dart';
import 'package:mobile_computing_project/util.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mobile_computing_project/screens/HomeUser.dart';

class LogInPage extends StatefulWidget {

  bool user;
  //LogInPage({Key key}) : super(key: key);

  LogInPage({required final this.user}); // can we put final for this field?


  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late TextEditingController textController1;
  late TextEditingController textController2;

  //final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF94F9E1),
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
        title: Text('Log In', style: appBarTextStyle,),
      ),
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
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                child: SizedBox(
                  width: 285,
                  height: 40,
                  child: Stack(
                    children: [
                      TextFormField(
                        controller: textController1,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: GoogleFonts.getFont(
                            'Lato',
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: GoogleFonts.getFont(
                          'Lato',
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const Align(
                        alignment: AlignmentDirectional(1, 0.1),
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.black,
                          size: 24,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                child: SizedBox(
                  width: 285,
                  height: 40,
                  child: Stack(
                    children: [
                      TextFormField(
                        controller: textController2,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: GoogleFonts.getFont(
                            'Lato',
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: GoogleFonts.getFont(
                          'Lato',
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const Align(
                        alignment: AlignmentDirectional(1, 0.1),
                        child: Icon(
                          Icons.lock_open,
                          color: Colors.black,
                          size: 24,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 130,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration:const Duration(milliseconds: 300),
                        reverseDuration:const Duration(milliseconds: 300),
                        child:HomeUser(),
                    ),
                    );
                  },
                  style: myButtonStyle,
                  child: Text('Enter', style: labelStyleForButton),
                ),
              ),
              const Spacer(),
              InkWell(
                child: Text(
                  'I Don\'t Have an account',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Lato',
                    color: Colors.black,
                  ),
                ),
                onTap: (){
                  if(widget.user) {
                    Navigator.push(context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 300),
                        reverseDuration: const Duration(milliseconds: 300),
                        child: SingInUser(),
                      ),
                    );
                  }
                  else{
                    Navigator.push(context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 300),
                        reverseDuration: const Duration(milliseconds: 300),
                        child: SingInExpertPage(),
                      ),
                    );
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
