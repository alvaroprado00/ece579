import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_computing_project/sing_in_user_email.dart';
import 'package:mobile_computing_project/util.dart';
import 'package:page_transition/page_transition.dart';

class SingInUser extends StatefulWidget {
  //SingInUserWidget({Key key}) : super(key: key);

  @override
  _SingInUserState createState() => _SingInUserState();
}

class _SingInUserState extends State<SingInUser> {
  late TextEditingController textController1;
  late TextEditingController textController2;
 // final formKey = GlobalKey<FormState>();
  // final scaffoldKey = GlobalKey<ScaffoldState>();

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
        backgroundColor: Color(0xFF94F9E1),
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
        title: Text('User Info', style: appBarTextStyle,),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 30,
              child: Padding(

                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Lottie.asset(
                  'lib/assets/lottie_animations/sing_in_animation_sun.json',
                  width: 300,
                  height: 130,
                  fit: BoxFit.fill,
                  animate: true,
                ),
              ),
            ),
            const Spacer(flex: 3),
            Text(
              'Welcome to the family',
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Lato',
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
            ),
            const Spacer(flex: 7),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: const BoxDecoration(
                    color: Color(0xFF94F9E1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.perm_identity,
                    color: Colors.black,
                    size: 44,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 20, 30, 0),
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
                      if (val!.isEmpty) {
                        return 'Field is required';
                      }

                      return null;
                    },
                  ),
                )
              ],
            ),
            const Spacer(flex: 10),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: const BoxDecoration(
                    color: Color(0xFF94F9E1),
                    shape: BoxShape.circle,
                  ),
                  child:const  Align(
                    alignment: AlignmentDirectional(-0.05, 0),
                    child: Icon(
                      Icons.lock_outlined,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  child: TextFormField(
                    onChanged: (_) => setState(() {}),
                    controller: textController2,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: ' Password',
                      hintStyle: myHintStyle,
                      enabledBorder:myUnderlineInputBorderForTextField,
                      focusedBorder:myUnderlineInputBorderForTextField,
                      suffixIcon: textController2.text.isNotEmpty
                          ? InkWell(
                        onTap: () => setState(
                              () => textController2.clear(),
                        ),
                        child:const Icon(
                          Icons.clear,
                          color: Colors.black,
                          size: 22,
                        ),
                      )
                          : null,
                    ),
                    style:myTextFieldStyle,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Field is required';
                      }

                      return null;
                    },
                  ),
                )
              ],
            ),
            const Spacer(flex: 15),
            SizedBox(
              width: 130,
              height: 40,

              child: ElevatedButton.icon(
                onPressed:(){

                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      duration:const Duration(milliseconds: 300),
                      reverseDuration:const Duration(milliseconds: 300),
                      child: UserEmailPage(),
                    ),
                  );
                },

                icon:const Icon(
                  Icons.navigate_next,
                  color: Colors.black,
                  size: 15,

                ),
                style: myButtonStyle,

                label:
                Text('Next', style: labelStyleForButton),
              ),
            ),

            const Spacer(flex: 3),

          ],
        ),
      ),
    );
  }
}
