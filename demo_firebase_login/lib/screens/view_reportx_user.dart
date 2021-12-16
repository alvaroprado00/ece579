import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase_login/components/message_list.dart';
import 'package:demo_firebase_login/controller/expert_dao.dart';
import 'package:demo_firebase_login/controller/user_dao.dart';
import 'package:demo_firebase_login/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_firebase_login/components/message_card.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ViewReportUserX extends StatefulWidget {
  //ViewReportUserXWidget({Key key}) : super(key: key);

  @override
  _ViewReportUserXState createState() => _ViewReportUserXState();
}

class _ViewReportUserXState extends State<ViewReportUserX> {
  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String _title = "";
  String _category = "";
  String _description = "";
  String _reportID = "";
  String _dateCreation ="";
  late Future<bool> isAdmin;
  String usernameUser = "";
  String usernameExpert= "Expert";


  _loadVariablesSP() async{
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get()
        .then((DocumentSnapshot snapshot) => usernameUser = snapshot.get('userName'));
    /*
    FirebaseFirestore.instance.collection('expert').doc(FirebaseAuth.instance.currentUser!.uid).get()
        .then((DocumentSnapshot snapshot) => usernameExpert = snapshot.get('userName'));
        */
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _title = (sp.getString('title') ?? 'Title not found');
      _description = (sp.getString('description') ?? 'Description not found');
      _category = (sp.getString('category') ?? 'category not found');
      _reportID = (sp.getString('reportID') ?? 'error');
      _dateCreation = (sp.getString('creationDate')??'no date found');
    });
  }

  Future<bool>checkAdmin() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return isUser(uid: userId);
  }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    _loadVariablesSP();
    //isAdmin = checkAdmin();
  }

  @override
  Widget build(BuildContext context) {
      return FutureBuilder(
        future: checkAdmin(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasError) {
            return Text("error loading the page please refresh");
          }
          if(snapshot.hasData && snapshot.data==false /* user is EXPERT*/){
            return Scaffold(
              key: scaffoldKey,
              appBar: getCustomAppBar(text: _title),
              backgroundColor: Colors.white,
              body: SafeArea(
                child: ListView(
                  padding: EdgeInsets.zero,
                  //scrollDirection: Axis.vertical,
                  //shrinkWrap: true,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: const Color(0xFF94F9E1),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 15, 15, 25),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  0, 10, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${_description}',
                                                    style: myTextFieldStyle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0,0),
                                              child: Text(
                                                'creation date: ${_dateCreation}',
                                                style: myDateStyle,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                ),
                                MessageList(_reportID), // HERE WE DISPLAY MSG
                                // BELLOW IS THE INPUT TEXT CARD
                                Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: Colors.white,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 15, 15, 25),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            TextFormField(
                                              controller: textController,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                hintText: 'type your answer here...',
                                                hintStyle: myHintStyle,
                                                enabledBorder: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.only(
                                                    topLeft: Radius.circular(4.0),
                                                    topRight: Radius.circular(4.0),
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                    topLeft: Radius.circular(4.0),
                                                    topRight: Radius.circular(4.0),
                                                  ),
                                                ),
                                              ),
                                              style: myTextFieldStyle,
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(10, 30, 0, 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    height:50,
                                                    width: 150,
                                                    child: ElevatedButton.icon(
                                                      onPressed: () {
                                                        if (textController.text != '') {
                                                          ScaffoldMessenger.of(context)
                                                              .showSnackBar(SnackBar(
                                                              content: Text(
                                                                'Sending message...',
                                                                style: myMessageStyle,
                                                              ),
                                                              backgroundColor:
                                                              Color(0xFF94F9E1)));
                                                        }
                                                        sendMessage(
                                                            message: textController.text,
                                                            reportID: _reportID,
                                                            isAdmin: true,
                                                            username: usernameExpert,
                                                        ).then((value) =>
                                                            expertSaveReport(reportID: _reportID,expertID: FirebaseAuth.instance.currentUser!.uid));
                                                        textController.clear();
                                                      },
                                                      icon: const Icon(
                                                        Icons.navigate_next,
                                                        size: 15,
                                                        color: Colors.black,
                                                      ),
                                                      style: myButtonStyle,
                                                      label: Text('Send message',
                                                          style: labelStyleForButton),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                    width: 150,
                                                    child: ElevatedButton.icon(
                                                      onPressed: () {
                                                          ScaffoldMessenger.of(context)
                                                              .showSnackBar(SnackBar(
                                                              content: Text(
                                                                'FBI IS ON THE WAY...',
                                                                style: myMessageStyle,
                                                              ),
                                                              backgroundColor: Colors.red
                                                              ));
                                                      },
                                                      icon: const Icon(
                                                        Icons.navigate_next,
                                                        size: 15,
                                                        color: Colors.black,
                                                      ),
                                                      style: myButtonStyleEmergency,
                                                      label: Text('Alert authority',
                                                          style: labelStyleForButton),
                                                    ),
                                                  )],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          if(snapshot.hasData && snapshot.data==true /*user in no expert*/){
            return Scaffold(
              key: scaffoldKey,
              appBar: getCustomAppBar(text: _title),
              backgroundColor: Colors.white,
              body: SafeArea(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: const Color(0xFF94F9E1),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 15, 15, 25),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  0, 10, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'creation date: ${_dateCreation}',
                                                    style: myTextFieldStyle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0, 0),
                                              child: Text(
                                                '${_description}',
                                                style: myTextFieldStyle,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                ),
                                MessageList(_reportID), // HERE WE DISPLAY MSG
                                // BELLOW IS THE INPUT TEXT CARD
                                Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: Colors.white,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 15, 15, 25),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            TextFormField(
                                              controller: textController,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                hintText: 'type your answer here...',
                                                hintStyle: myHintStyle,
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                    topLeft: Radius.circular(4.0),
                                                    topRight: Radius.circular(4.0),
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                    topLeft: Radius.circular(4.0),
                                                    topRight: Radius.circular(4.0),
                                                  ),
                                                ),
                                              ),
                                              style: myTextFieldStyle,
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  0, 15, 0, 0),
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                  if (textController.text != '') {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(SnackBar(
                                                        content: Text(
                                                          'Sending message...',
                                                          style: myMessageStyle,
                                                        ),
                                                        backgroundColor:
                                                        Color(0xFF94F9E1)));
                                                  }
                                                  sendMessage(
                                                      message: textController.text,
                                                      reportID: _reportID,
                                                      isAdmin: false,
                                                      username: usernameUser,
                                                  )
                                                      .then((value) => textController.clear());
                                                },
                                                icon: const Icon(
                                                  Icons.navigate_next,
                                                  size: 15,
                                                  color: Colors.black,
                                                ),
                                                style: myButtonStyle,
                                                label: Text('Send message',
                                                    style: labelStyleForButton),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          else {
            return Text("Loading...");
          }
        });
    }
  }

Future<void> sendMessage({required String message, required String reportID, required bool isAdmin,required String username}) async{
  SharedPreferences sp = await SharedPreferences.getInstance();
  String _reportID = (sp.getString('reportID') ?? 'error');
  try{
    if(message!=''&& reportID == _reportID){
      sendMessageFirestore(message: message, reportID: reportID, isAdmin : isAdmin, username : username);
    }
  } catch (e){
    print("error sending msg");
  }
}

Future<void> expertSaveReport(
    {required String reportID, required String expertID}) async{
  List<String> expertToSave = [];
  expertToSave.add(expertID);
  if(reportID!='' && expertID !=''){
    try{
        saveReportExpertList(expertToSaveID: expertToSave, reportID: reportID);
    }catch(e) {
      print("Report could not be saved in expert list");
    }
  }
}