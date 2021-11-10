
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_computing_project/util.dart';

class DiplomaPage extends StatefulWidget {
  //DiplomaPageWidget({Key key}) : super(key: key);

  @override
  _DiplomaPageState createState() => _DiplomaPageState();
}

class _DiplomaPageState extends State<DiplomaPage> {
  String dropDownValue='Bullying';
  late TextEditingController textController;
  //bool _loadingButton = false;
  //final formKey = GlobalKey<FormState>();
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
        title: Text('Diploma', style: appBarTextStyle,),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Spacer(flex:3),
            Text(
              'At last but not least',
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Lato',
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
            ),
            const Spacer(flex:4),
            Text(
              'Select your expertise:',
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Lato',
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            DropdownButton(
              value: dropDownValue,
              items: <String>['Bullying']
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
            const Spacer(flex: 4),
            Text(
              'Attach  a photo of your diploma:',
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Lato',
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 20,
              ),
            ),
            const Spacer(),

              RawMaterialButton(
                onPressed:(){

                },
                child:const Icon(
                  Icons.add,
                  color: Colors.black,
                  size:70,
                ),
                elevation: 2.0,
                fillColor: const Color(0xFF94F9E1),
                shape: const CircleBorder(),

              ),

            const Spacer(flex: 4),

              Text(
                'Tell us about yourself:',
                style: GoogleFonts.getFont(
                  'Lato',
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            const Spacer(),
            Padding(

              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
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
                  const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
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

              },

              icon:const Icon(
                Icons.done,
                color: Colors.black,
              ),
              style: myButtonStyle,

              label:
              Text('Done', style: labelStyleForButton),
            ),
            Spacer(flex: 2)
          ],
        ),
      ),
    );
  }
}
