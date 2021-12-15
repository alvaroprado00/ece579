import 'package:flutter/material.dart';
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:demo_firebase_login/model/user_report.dart';
import 'package:demo_firebase_login/controller/user_dao.dart';
import 'package:demo_firebase_login/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CreateReportUser extends StatefulWidget {
  //CreateReportUserWidget({Key key}) : super(key: key);

  @override
  _CreateReportUserState createState() => _CreateReportUserState();
}

class _CreateReportUserState extends State<CreateReportUser> {
  String dropDownValue = "bullying";
  late TextEditingController textController1;
  late TextEditingController textController2;
  final formKey = GlobalKey<FormState>();
  late String currentDate;

  
  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    currentDate = DateTime.now().toLocal().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: getCustomAppBar(text: ('Create new report')),
        backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Form(
          key: formKey,
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
                                onChanged: (_) => setState(
                                        () {}),
                                controller: textController1,
                                obscureText: false,
                                decoration: InputDecoration(
                                    hintText: 'Report title',
                                    hintStyle: myHintStyle,
                                    enabledBorder:myUnderlineInputBorderForTextField,
                                    focusedBorder:myUnderlineInputBorderForTextField,
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
                                maxLines: 1,
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
                                padding:
                                const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: TextFormField(
                                controller: textController2,
                                obscureText: false,
                                decoration: InputDecoration(
                                hintText:'Explain to us what happened',
                                hintStyle: myHintStyle,
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
                            if (formKey.currentState!.validate()){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Creating your report',
                                  style: myMessageStyle,), backgroundColor: Color(0xFF94F9E1),),
                              );
                              createReport(title: textController1.text,
                                  category: dropDownValue,
                                  description: textController2.text,
                                  uid : FirebaseAuth.instance.currentUser!.uid,
                                  chat: ['start of conversation with expert'],
                                  date: currentDate.substring(0,currentDate.indexOf('.')),
                              )
                              .then((value) => Navigator.pop(context));
                            }
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
      ),
    );
  }
}


Future<void> createReport({
  required String title,
  required String description,
  required String category,
  required String uid,
  required List<String> chat,
  required String date,
}) async{
  try{
    UserReport ur = UserReport(title: title, category: category ,description: description,uId: uid,chat: chat,date: date);
    if(ur.title != '' && ur.category !='' && ur.description != '' && ur.uId !=''&& chat.length==1){
      return createUserReport(ur: ur);
    } else {
      print('Cannot create report because 1 field is missing');
    }
  } catch (e) {
    print("Error when reading data");
  }
}