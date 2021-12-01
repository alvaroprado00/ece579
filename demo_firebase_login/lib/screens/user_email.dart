import 'package:demo_firebase_login/controller/user_dao.dart';
import 'package:demo_firebase_login/model/user_custom.dart';
import 'package:demo_firebase_login/screens/login_page.dart';
import 'package:demo_firebase_login/screens/util_logic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class UserEmailPage extends StatefulWidget {
  //UserEmailPageWidget({Key key}) : super(key: key);

  @override
  _UserEmailPageState createState() => _UserEmailPageState();
}

class _UserEmailPageState extends State<UserEmailPage> {

  late TextEditingController textController;
  final formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      appBar: getCustomAppBar(text: 'Email'),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 30),
                  child: Lottie.asset(
                    'assets/lottie_animations/email.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                    frameRate: FrameRate(20),
                    animate: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 20, 30, 30),
                  child: TextFormField(
                    onChanged: (_) => setState(() {}),
                    controller: textController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Email address',
                      enabledBorder: myUnderlineInputBorderForTextField,
                      focusedBorder: myUnderlineInputBorderForTextField,
                      suffixIcon: textController.text.isNotEmpty
                          ? InkWell(
                              onTap: () => setState(
                                () => textController.clear(),
                              ),
                              child: const Icon(
                                Icons.clear,
                                color: Colors.black,
                                size: 22,
                              ),
                            )
                          : null,
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.emailAddress,
                    validator: validatorForEmail)
                ),
                SizedBox(
                  width: 130,
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Creating User', style: myMessageStyle,),backgroundColor: Color(0xFF94F9E1),),
                        );

                        createUser(email: textController.text).then(
                          (value) => Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              (Route<dynamic> route) => false),
                        );
                      }
                    },
                    style: myButtonStyle,
                    icon: const Icon(
                      Icons.done,
                      size: 15,
                      color: Colors.black,
                    ),
                    label: Text('Enter', style: labelStyleForButton),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 50, 30, 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/alert.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                          child: Text(
                            'Your email information will never be shared without your consent',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.getFont(
                              'Lato',
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> createUser({required String email}) async {
  //We need to access the info from the previous page that was set in preferences

  SharedPreferences sp = await SharedPreferences.getInstance();

  try {
    UserCustom uc =
        UserCustom(userName: sp.getString('userName') ?? '', email: email);
    String password = sp.getString('password') ?? '';

    if (uc.userName != '' && password != '') {
      return addUser(u: uc, password: password);
    } else {
      print('Null value retrieved from Shared Preferences');
    }
  } catch (e) {
    print("Error when getting userName from Shared Preferences");
  }
}
