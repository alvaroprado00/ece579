import 'package:flutter/material.dart';
import 'package:mobile_computing_project/util.dart';


class CreateReportUser extends StatefulWidget {
  //CreateReportUserWidget({Key key}) : super(key: key);

  @override
  _CreateReportUserState createState() => _CreateReportUserState();
}

class _CreateReportUserState extends State<CreateReportUser> {
  String dropDownValue = "";
  late TextEditingController textController1;
  late TextEditingController textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF94F9E1),
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 4,
        title: Text('New report',style: appBarTextStyle,),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Align(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 25),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                            child: TextFormField(
                              controller: textController1,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Report title',
                                hintStyle: myHintStyle,
                                enabledBorder:myUnderlineInputBorderForTextField,
                                focusedBorder:myUnderlineInputBorderForTextField
                              ),
                              style: myTextFieldStyle,
                              maxLines: 1,
                            ),
                          ),
                          DropdownButton<String>(

                            value : dropDownValue.isNotEmpty ? dropDownValue : null,
                            items: <String>[
                              'Family issue',
                              'whatever']
                                .map<DropdownMenuItem<String>>((String value){
                              return DropdownMenuItem<String>(value: value,
                              child: Text(value,style: myTextFieldStyle,),
                              );
                            }).toList(),
                            onChanged: (String? value) =>
                                setState(() => dropDownValue = value!),
                          ),
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: TextFormField(
                              controller: textController2,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum gravida mattis lorem, et posuere tortor rutrum vitae. Vivamus lacinia fringilla libero, at maximus quam imperdiet sed. Pellentesque egestas eget ex a consectetur.\n',
                                hintStyle: myHintStyle,
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
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
                              style: myTextFieldStyle,
                              textAlign: TextAlign.justify,
                              maxLines: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                      child: ElevatedButton.icon(
                        onPressed:(){
                          print("we call function to submit to database");
                        },
                        icon:const Icon(
                          Icons.done,
                          size: 15,
                          color: Colors.black,
                        ),
                        style: myButtonStyle,
                        label:
                        Text('Submit report', style: labelStyleForButton),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}