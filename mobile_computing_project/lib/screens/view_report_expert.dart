import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_computing_project/screens/view_report_expertX.dart';
import 'package:mobile_computing_project/screens/view_report_userX.dart';
import 'package:mobile_computing_project/util.dart';
import 'package:page_transition/page_transition.dart';



// WHY IS Background blue and not white?
class ViewReportExpert extends StatefulWidget {
  //ViewReportUser({Key key}) : super(key: key);

  @override
  _ViewReportExpertState createState() => _ViewReportExpertState();
}

class _ViewReportExpertState extends State<ViewReportExpert> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String dropDownValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF94F9E1),
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
        title: Text('Report list',style: appBarTextStyle,),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          children: [
          Container(
            width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
              color: Colors.white,
            ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                // add style dropdown
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFFC52121),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-0.1, -0.5),
                                child: Text(
                                  'Report title 1 ',
                                  style: labelStyleForButton
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  'Category whatever',
                                  style: myTextFieldStyle,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(2.64, 0.55),
                                child: Text(
                                  'Date created/last answer',
                                  textAlign: TextAlign.start,
                                  style: myTextFieldStyle
                                ),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.05, 0),
                          child: IconButton(
                            icon: Icon(Icons.chevron_right),
                            color: Colors.black,
                            onPressed:(){
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  duration:const Duration(milliseconds: 300),
                                  reverseDuration:const Duration(milliseconds: 300),
                                  child: ViewReportExpertX(),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          ),],
          ),
    ),
    );
  }
}
