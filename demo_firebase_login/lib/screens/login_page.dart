import 'package:demo_firebase_login/screens/sign_up_expert.dart';
import 'package:demo_firebase_login/screens/util_logic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:demo_firebase_login/screens/sign_up_user.dart';
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:page_transition/page_transition.dart';

import 'main.dart';

class LogInPage extends StatefulWidget {

  TypeOfUser typeOfUser;
  //LogInPage({Key key}) : super(key: key);

  LogInPage({required this.typeOfUser});


  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  // The text controllers let us manage the info written in the txt fields

  late TextEditingController textController1;
  late TextEditingController textController2;

  final formKey= GlobalKey<FormState>();

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
      appBar: getCustomAppBar(text: "Log In"),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Align(
              alignment: const AlignmentDirectional(0, -0.3),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0,30),
                    child: Container(
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
                  ),

                  //Here we create both the text forms
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 120, 0, 30),
                    child: getCustomTextFormField(textController: textController1, obscureText: false, hintText: 'Email', validationFunction: validatorForNotEmpty, icon: Icons.mail),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                    child: getCustomTextFormField(textController: textController2, obscureText: true, hintText: 'Password', validationFunction: validatorForPassword, icon: Icons.lock_outlined),
                  ),

                  SizedBox(
                    width: 130,
                    height: 40,
                    child: ElevatedButton(
                      child:Text("Log In", style: labelStyleForButton,),
                      onPressed: () {

                        // After validating we sign in and return to Home Page with updated state of application
                        if(formKey.currentState!.validate()) {

                          //We specify also a function to execute in case of error
                          signInWithEmailAndPassword(textController1.text, textController2.text, (e) {showAlertDialog(context:context, error:e.toString());}).then((val){

                              //The future is completed and we check if it went well
                              if(val) {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
                              }else{
                                textController1.clear();
                                textController2.clear();
                              }

                          });
                        }

                      },
                      style: myButtonStyle,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 10),
                    child: InkWell(
                      child: Text(
                        'I Don\'t Have an account',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Lato',
                          color: Colors.black,
                        ),
                      ),
                      onTap: (){
                        if(widget.typeOfUser==TypeOfUser.user) {
                          Navigator.push(context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 300),
                              reverseDuration: const Duration(milliseconds: 300),
                              child: SignUpUser(),
                            ),
                          );
                        }
                        else{
                          Navigator.push(context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            duration: const Duration(milliseconds: 300),
                            reverseDuration: const Duration(milliseconds: 300),
                            child: SignUpExpert(),
                          ),
                        );
                        }
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}


Future<bool> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
    ) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return true;
  } on FirebaseAuthException catch (e) {
    errorCallback(e);
    return false;
  }
}

