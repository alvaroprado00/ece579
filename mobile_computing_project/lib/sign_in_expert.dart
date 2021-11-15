
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_computing_project/util.dart';
import 'package:page_transition/page_transition.dart';
import 'contact_info_expert.dart';

class SingInExpertPage extends StatefulWidget {
  //SingInExpertWidget({Key key}) : super(key: key);

  @override
  _SingInExpertPageState createState() => _SingInExpertPageState();
}

class _SingInExpertPageState extends State<SingInExpertPage> {
  late TextEditingController textController1;
  late TextEditingController textController2;
  //bool _loadingButton = false;
  //final formKey = GlobalKey<FormState>();
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 60,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Lottie.asset(
                  'lib/assets/lottie_animations/sing_in_expert.json',
                  width: 200,
                  height: 130,
                  fit: BoxFit.fill,
                  repeat: false,
                  animate: true,
                ),
              ),
            ),
            const Spacer(flex: 3),
            Text(
              'We are really happy to have you here!',
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Lato',
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
            ),
            const Spacer(flex: 9),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                getRoundedIcon(icon: Icons.person),
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
                getRoundedIcon(icon: Icons.lock),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  child: TextFormField(
                    onChanged: (_) => setState(() {}),
                    controller: textController2,
                    obscureText: false,
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
            ElevatedButton.icon(
              onPressed:(){
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration:const Duration(milliseconds: 300),
                    reverseDuration:const Duration(milliseconds: 300),
                    child: ContactInfoPage(),
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
              Text('Next', style: labelStyleForButton),
            ),
            Spacer(flex:5),
          ],
        ),
      ),
    );
  }
}
