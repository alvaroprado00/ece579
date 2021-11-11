
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_computing_project/Diploma.dart';
import 'package:mobile_computing_project/util.dart';
import 'package:page_transition/page_transition.dart';

class ContactInfoPage extends StatefulWidget {
  //ContactInfoExpertWidget({Key key}) : super(key: key);

  @override
  _ContactInfoPageState createState() =>
      _ContactInfoPageState();
}

class _ContactInfoPageState extends State<ContactInfoPage> {
  String dropDownValue='(US) +1';
  late TextEditingController textController2;
  late TextEditingController textController1;
  //bool _loadingButton = false;
 // final formKey = GlobalKey<FormState>();
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
       appBar: AppBar(
        backgroundColor: const Color(0xFF94F9E1),
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
         title:Text('Contact Info', style: appBarTextStyle,) ,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
              child: Text(
                'We need some extra information, so we can contact you!',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Lato',
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 25,
                ),
              ),
            ),
            //const Spacer(flex: 3),
            Padding(
              
              padding:  const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 50),
              child: Lottie.asset(
                'lib/assets/lottie_animations/contact_info.json',
                width: 100,
                height: 150,
                fit: BoxFit.contain,
                repeat: false,
                animate: true,
              ),
            ),
           // const Spacer(flex: 7),
            Column(
              //mainAxisSize: MainAxisSize.max,
              children: [
               getRoundedIcon(icon: Icons.alternate_email),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(30, 20, 30, 0),
                  child: TextFormField(
                    onChanged: (_) => setState(() {}),
                    controller: textController1,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Email Address',
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
                    style:myTextFieldStyle,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.emailAddress,
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
            //const Spacer(flex: 10),
            Column(
              //mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:  const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child:  getRoundedIcon(icon:Icons.phone_android),
                ),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: DropdownButton(
                        value: dropDownValue,
                        items: <String>['(Spain) +34',
                          '(US) +1',
                          '(France) +33']
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

                    ),
                    Expanded(
                      child: Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                        child: TextFormField(
                          onChanged: (_) => setState(() {}),
                          controller: textController2,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: myHintStyle,
                            enabledBorder: myUnderlineInputBorderForTextField,
                            focusedBorder: myUnderlineInputBorderForTextField,
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
                          keyboardType: TextInputType.phone,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Field is required';
                            }

                            return null;
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            //const Spacer(flex: 7),

            Padding(
              padding:const EdgeInsetsDirectional.fromSTEB(140, 50, 140, 30),

              child: ElevatedButton.icon(
                onPressed:(){
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration:const Duration(milliseconds: 300),
                      reverseDuration:const Duration(milliseconds: 300),
                      child: DiplomaPage(),
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
            ),
          ],
        ),
      ),
    );
  }
}
