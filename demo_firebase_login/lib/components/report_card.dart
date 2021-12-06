import 'package:demo_firebase_login/model/user_report.dart';
import 'package:demo_firebase_login/screens/view_reportx_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetReportList extends StatelessWidget{
    final String uid;
    GetReportList(this.uid);
    CollectionReference userReports = FirebaseFirestore.instance.collection("reports");

    @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: userReports.where("uid", isEqualTo: uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasError) {
          return Text("Error fetching reports");
        }

        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          if(snapshot.hasData && documents.length==0) {
            return Text("No reports found");
          }
          else {
            return Column(
              // listview
                //shrinkWrap: true,
                //scrollDirection: Axis.vertical,
                children: documents.map((doc) =>
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: const Color(0xFF94F9E1),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 25),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(doc['title'],
                                          //"title: ${data['title']}",
                                          style: labelStyleForButton
                                      ),
                                      Text(
                                          doc['category'],
                                          //"category: ${data['category']}",
                                          style: myHintStyle
                                      ),
                                      IconButton(
                                          onPressed: () {
                                                Navigator.push(
                                                context,
                                                PageTransition(
                                                type: PageTransitionType.rightToLeft,
                                                duration:const Duration(milliseconds: 300),
                                                reverseDuration:const Duration(milliseconds: 300),
                                                child: ViewReportUserX(),
                                                ),
                                                );
                                          },
                                          icon:
                                          Icon(Icons.arrow_forward))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 0),
                                  child: Text(
                                    doc['description'],
                                    //"description: ${data['description']}",
                                    style: myTextFieldStyle,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),).toList()
            );
          }
        }else{
          return Text("loading reports for ${uid}");
        }
      },
    );
  }
}

/**
    print("${FirebaseFirestore.instance.collection('reports').where('uid', isEqualTo: uid)
    .get().
    then((QuerySnapshot querySnapshot){
    querySnapshot.docs.forEach((doc) {
    print(doc['category']);
    });
    })}");



    Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    color: const Color(0xFF94F9E1),
    elevation: 3,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    Padding(
    padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 25),
    child: Column(
    mainAxisSize: MainAxisSize.max,
    children: [
    Padding(
    padding:
    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
    child: Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(doc['title'],
    //"title: ${data['title']}",
    style: labelStyleForButton
    ),
    Text(
    doc['category'],//"category: ${data['category']}",
    style: labelStyleForButton
    ),
    IconButton(
    onPressed:(){
    print("poo poo");
    /**
    Navigator.push(
    context,
    PageTransition(
    type: PageTransitionType.rightToLeft,
    duration:const Duration(milliseconds: 300),
    reverseDuration:const Duration(milliseconds: 300),
    child: ViewReportUserX(),
    ),
    );**/
    },
    icon:
    Icon(Icons.arrow_forward))
    ],
    ),
    ),
    Padding(
    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
    child: Text(
    doc['description'],//"description: ${data['description']}",
    style: myTextFieldStyle,
    ),
    ),
    ],
    ),
    )
    ],
    ),
    ),).toList()
 **/