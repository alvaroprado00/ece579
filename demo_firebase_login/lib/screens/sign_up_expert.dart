
import 'package:demo_firebase_login/screens/contact_info_expert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignUpExpert extends StatefulWidget {
  //SingInExpertWidget({Key key}) : super(key: key);

  @override
  _SignUpExpertState createState() => _SignUpExpertState();
}

class _SignUpExpertState extends State<SignUpExpert> {
  late TextEditingController textController1;
  late TextEditingController textController2;
  //bool _loadingButton = false;
  final formKey = GlobalKey<FormState>();
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
      //key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF94F9E1),
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
        title: Text('Expert Info',style: appBarTextStyle,),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Form(
          key:formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 100),
                  child: Lottie.asset(
                    'assets/lottie_animations/sing_in_expert.json',
                    width: 220,
                    height: 150,
                    fit: BoxFit.cover,
                    repeat: false,
                    animate: true,
                  ),
                ),

                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                  child: Text(
                    'We are really happy to have you here!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 25,
                    ),
                  ),
                ),

                getRoundedIcon(icon: Icons.person),

                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 30),
                  child: TextFormField(
                    onChanged: (_) => setState(() {}),
                    controller: textController1,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'User Name',
                      hintStyle:myHintStyle,
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
                    validator: (val) {
                      if (val!.isEmpty|| val==null) {
                        return 'Field is required';
                      }
                      return null;
                    },
                  ),
                ),

                getRoundedIcon(icon: Icons.lock),

                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 30),
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
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) {
                      if (val!.isEmpty || val==null) {
                        return 'Field is required';
                      }else if(val.length<6){
                        return 'Password should at least have 6 characters';
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                  child: ElevatedButton.icon(
                    onPressed:(){
                      if(formKey.currentState!.validate()) {
                        updateSharedPreferencesExpert();
                      }
                    },
                    icon:const Icon(
                      Icons.navigate_next,
                      size: 15,
                      color: Colors.black,
                    ),
                    style: myButtonStyle,
                    label:
                    Text('Next', style: labelStyleForButton),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateSharedPreferencesExpert() async {
    SharedPreferences sp= await SharedPreferences.getInstance();

    sp.setString('userNameExpert', textController1.text);
    sp.setString('passwordExpert', textController2.text);

    //Clear text fields

    textController1.clear();
    textController2.clear();

    //Once I set the info I go to the next page

    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        duration:const Duration(milliseconds: 300),
        reverseDuration:const Duration(milliseconds: 300),
        child:ContactInfoPage(),
      ),
    );
  }
}


