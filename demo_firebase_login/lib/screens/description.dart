
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'diploma.dart';

class DecriptionPage extends StatefulWidget {
  //DiplomaPageWidget({Key key}) : super(key: key);

  @override
  _DecriptionPageState createState() => _DecriptionPageState();
}

class _DecriptionPageState extends State<DecriptionPage> {
  String dropDownValue='bullying';
  late TextEditingController textController;
  //bool _loadingButton = false;
  final formKey = GlobalKey<FormState>();

  //final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
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
        title: Text('Expert Description', style: appBarTextStyle,),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 50, 5, 50),
                  child: Text(
                    'Why don\'t you tell us about yourself? ' ,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 25,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 30),
                  child: Text(
                    'Select your expertise:',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                ),

                DropdownButton(
                  value: dropDownValue,
                  items: <String>['bullying',
                    'child abuse',
                    'suicide',
                     'nutrition']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),

                  onChanged: (String? newValue) {
                    setState(() {
                      dropDownValue = newValue!;
                    });
                  },
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: myDropDownButtonStyle,
                ),

                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 100, 10, 20),
                  child: Text(
                    'Tell us about yourself:',
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 50),
                  child: TextFormField(
                    controller: textController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'What\'s your experience in this field:',
                      hintStyle: myHintStyle,
                      enabledBorder: OutlineInputBorder(
                        borderSide:const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding:
                      const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    ),
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 7,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Field is required';
                      }

                      return null;
                    },
                  ),
                ),

                ElevatedButton.icon(
                  onPressed:(){

                    contactInfoSharedPreferences();

                  },
                  icon:const Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  ),
                  style: myButtonStyle,
                  label:
                  Text('Next', style: labelStyleForButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void contactInfoSharedPreferences() async {

    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setString('expertise', dropDownValue);
    sp.setString('description', textController.text);

    //Clear text fields

    textController.clear();

    //Once I set the info I go to the next page

    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300),
        child:DiplomaPage(),
      ),
    );
  }
}

