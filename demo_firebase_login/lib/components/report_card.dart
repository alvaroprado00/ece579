import 'package:demo_firebase_login/model/user_report.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetReportList extends StatelessWidget{
    final String uId;
    GetReportList(this.uId);

  @override
  Widget build(BuildContext context) {
    CollectionReference reports = FirebaseFirestore.instance.collection('reports');
    return FutureBuilder<DocumentSnapshot>(
      future: reports.doc(uId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Card(
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
                            Text(
                                "title: ${data['title']}",
                                style: labelStyleForButton
                            ),
                            Text(
                                "category: ${data['category']}",
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
                        child: Text("description: ${data['description']}",
                          style: myTextFieldStyle,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return Text("loading");
      },
    );
  }
}
