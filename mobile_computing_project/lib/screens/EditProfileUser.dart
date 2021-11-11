import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_computing_project/util.dart';


class EditProfileUser extends StatefulWidget {
  //EditProfileUser({Key key}) : super(key: key);

  @override
  _EditProfileUserState createState() => _EditProfileUserState();
}

class _EditProfileUserState extends State<EditProfileUser> {
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 80,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Text(
                        'Hi, \$USER',
                        style: myTextFieldStyle,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(
                    height: 1,
                    thickness: 2,
                    color: Colors.black,
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
                  Divider(
                    height: 1,
                    thickness: 2,
                    color: Colors.black,
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
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
                  Divider(
                    height: 1,
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
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
                      Divider(
                        height: 1,
                        thickness: 2,
                        color: Colors.black,
                      )
                    ],
                  ),
                  Divider(
                    height: 1,
                    thickness: 2,
                    color: Colors.black,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}