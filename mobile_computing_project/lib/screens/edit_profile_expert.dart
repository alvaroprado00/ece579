import 'package:flutter/material.dart';
import 'package:mobile_computing_project/util.dart';


class EditProfileExpert extends StatefulWidget {
  //EditProfileUser({Key key}) : super(key: key);

  @override
  _EditProfileExpertState createState() => _EditProfileExpertState();
}

class _EditProfileExpertState extends State<EditProfileExpert> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
        title: Text('Your profile',style: appBarTextStyle,),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            getRoundedIcon(icon: Icons.person),
            const Spacer(),
            Text(
              'Hi, \$USER',
              style: myTextFieldStyle,
            ),
            const Spacer(),
            getMyDivider(),
            const Spacer(),


            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Change your password',
                    style: myTextFieldStyle,
                  ),
                  IconButton(
                    icon: Icon(Icons.mode_outlined),
                    color: Colors.black,
                    onPressed:(){
                      print("poo poo");
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Change your email',
                    style: myTextFieldStyle,
                  ),
                  IconButton(
                    icon: Icon(Icons.mode_outlined),
                    color: Colors.black,
                    onPressed:(){
                      print("poo poo");
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Change your phone',
                    style: myTextFieldStyle,
                  ),
                  IconButton(
                    icon: Icon(Icons.mode_outlined),
                    color: Colors.black,
                    onPressed:(){
                      print("poo poo");
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Change your diploma info',
                    style: myTextFieldStyle,
                  ),
                  IconButton(
                    icon: Icon(Icons.mode_outlined),
                    color: Colors.black,
                    onPressed:(){
                      print("poo poo");
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            getMyDivider(),
            const Spacer(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Log out of your account',
                    style: myTextFieldStyle,
                  ),
                  IconButton(
                    icon: Icon(Icons.cancel),
                    color: Colors.black,
                    onPressed:(){
                      print("poo poo");
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Delete your account',
                      style: myTextFieldStyle
                  ),
                  IconButton(
                    icon: Icon(Icons.cancel),
                    color: Colors.red,
                    onPressed:(){
                      print("poo poo");
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            getMyDivider(),
            const Spacer(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Get help navigatige through the app',
                    style: myTextFieldStyle,
                  ),
                  IconButton(
                    icon: Icon(Icons.help),
                    color: Colors.black,
                    onPressed:(){
                      print("poo poo");
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Read terms',
                      style: myTextFieldStyle
                  ),
                  IconButton(
                    icon: Icon(Icons.info_rounded),
                    color: Colors.black,
                    onPressed:(){
                      print("poo poo");
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}