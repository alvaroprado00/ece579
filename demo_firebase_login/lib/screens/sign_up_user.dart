import 'package:demo_firebase_login/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:demo_firebase_login/screens/user_email.dart';
import 'package:demo_firebase_login/screens/util.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpUser extends StatefulWidget {
  //SingInUserWidget({Key key}) : super(key: key);

  @override
  _SignUpUserState createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  late TextEditingController textController1;
  late TextEditingController textController2;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      appBar: getCustomAppBar(text: 'User Info'),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 30),
                  child: Lottie.asset(
                    'assets/lottie_animations/sing_in_animation_sun.json',
                    width: 350,
                    height: 130,
                    fit: BoxFit.fill,
                    animate: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                  child: Text(
                    'Welcome to the family',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 25,
                    ),
                  ),
                ),
                getRoundedIcon(icon: Icons.perm_identity),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 20, 30, 30),
                  child: TextFormField(
                    onChanged: (_) => setState(() {}),
                    controller: textController1,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'User Name',
                      hintStyle: myHintStyle,
                      enabledBorder: myUnderlineInputBorderForTextField,
                      focusedBorder: myUnderlineInputBorderForTextField,
                      suffixIcon: textController1.text.isNotEmpty
                          ? InkWell(
                              onTap: () => setState(
                                () => textController1.clear(),
                              ),
                              child: const Icon(
                                Icons.clear,
                                color: Colors.black,
                                size: 22,
                              ),
                            )
                          : null,
                    ),
                    style: myTextFieldStyle,
                    textAlign: TextAlign.start,
                    validator: validatorForNotEmpty,
                  ),
                ),
                getRoundedIcon(icon: Icons.lock_outlined),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 20, 30, 30),
                  child: TextFormField(
                    onChanged: (_) => setState(() {}),
                    controller: textController2,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: ' Password',
                      hintStyle: myHintStyle,
                      enabledBorder: myUnderlineInputBorderForTextField,
                      focusedBorder: myUnderlineInputBorderForTextField,
                      suffixIcon: textController2.text.isNotEmpty
                          ? InkWell(
                              onTap: () => setState(
                                () => textController2.clear(),
                              ),
                              child: const Icon(
                                Icons.clear,
                                color: Colors.black,
                                size: 22,
                              ),
                            )
                          : null,
                    ),
                    style: myTextFieldStyle,
                    textAlign: TextAlign.start,
                    validator: validatorForPassword,
                  ),
                ),
                SizedBox(
                  width: 130,
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        updateSharedPreferencesUser();
                      }
                    },
                    icon: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                      size: 15,
                    ),
                    style: myButtonStyle,
                    label: Text('Next', style: labelStyleForButton),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateSharedPreferencesUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setString('userName', textController1.text);
    sp.setString('password', textController2.text);

    //Clear text fields

    textController1.clear();
    textController2.clear();

    //Once I set the info I go to the next page

    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRight,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300),
        child: UserEmailPage(),
      ),
    );
  }
}
