import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase_login/controller/user_dao.dart';
import 'package:demo_firebase_login/model/user_custom.dart';
import 'package:demo_firebase_login/screens/login_page.dart';
import 'package:demo_firebase_login/screens/util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'avatar.dart';
import 'main.dart';

class EditProfileUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
        builder: (context, appState, _) =>
            GetInfoUser(userId: appState.userId));
  }
}

class GetInfoUser extends StatelessWidget {
  String userId;

  GetInfoUser({
    Key? key,
    required this.userId,
  }) : super(key: key);

  //This is to have the active user as our Object UserCustom to have all the the info in this page
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: getActiveUser(uid: userId),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            UserCustom uc = UserCustom.fromJson(data);
            return infoFromUser(
              user: uc,
            );
          }

          return const SizedBox(height:150, width:150,child: CircularProgressIndicator());

        });
  }
}

class infoFromUser extends StatelessWidget {

  //In this widget we can display whatever info we want from the active user

  UserCustom user;

  infoFromUser({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:getCustomAppBar(text: 'Your profile info'),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              //AVATAR

              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 30),
                child: Avatar(
                  url: 'https://robohash.org/${user.userName}',
                  size: 200,
                ),
              ),

              //USER NAME
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 40),
                child: Text(
                  'Hi, ${user.userName}',
                  style: GoogleFonts.getFont('Lato', fontSize: 30),
                ),
              ),
              getMyDivider(),

              //ALL THE DIFFERENT FIELDS

              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                child: fieldModifier(
                    message: 'User Name: ${user.userName}',
                    icon: Icons.mode_outlined,
                    colorOfIcon: Colors.black,
                    todo: () {
                      displayTextInputDialog(context, 'User Name',
                          validatorForNotEmpty, updateUserNameForUser);
                    }),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                child: fieldModifier(
                    message: 'Email: ${user.email}',
                    icon: Icons.mode_outlined,
                    colorOfIcon: Colors.black,
                    todo: () {
                      displayTextInputDialog(context, 'Email',
                          validatorForNotEmpty, updateEmailForUser);
                    }),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                child: fieldModifier(
                    message: 'Password: ************',
                    icon: Icons.mode_outlined,
                    colorOfIcon: Colors.black,
                    todo:  () {
                      displayTextInputDialog(context, 'Email',
                          validatorForPassword, updatePasswordForUser);
                    }),
              ),
              getMyDivider(),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                child: fieldModifierWithContext(
                    message: 'Log out',
                    icon: Icons.cancel,
                    colorOfIcon: Colors.black,
                    todo: signOutFromUserProfile,
                    context: context),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                child: fieldModifierWithContext(
                    message: 'Delete Account',
                    icon: Icons.cancel,
                    colorOfIcon: Colors.red,
                    todo: deleteAccountFromUserProfile,
                  context: context,
                ),
              ),
              getMyDivider(),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                child: fieldModifier(
                    message: 'Help',
                    icon: Icons.info_rounded,
                    colorOfIcon: Colors.black,
                    todo: () => print('popo')),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                child: fieldModifier(
                    message: 'Terms and Conditions',
                    icon: Icons.info_rounded,
                    colorOfIcon: Colors.black,
                    todo: () => print('popo')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signOutFromUserProfile(BuildContext context) {
    // I call the function from user_dao and then go back to the HomePage since the state changes to logged_out
    signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
  }

  void deleteAccountFromUserProfile(BuildContext context) {
    //Call the function on the user dao

    deleteUserAccount().then((val) async {
      //I show a meesage to notify if everything went OK or if the user has not been deleted
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
        content: Text(
          val,
          style: myMessageStyle,
        ),
        backgroundColor: Color(0xFF94F9E1),
      ));

      //We have to wait for the Snackbar to dissappear

      await Future.delayed(Duration(seconds: 2));

      //Then navigate to entry point and clean stack

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));

    });
  }

  TextEditingController textFieldController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> displayTextInputDialog(
      BuildContext context,
      String field,
      String? Function(String?)? validatorFunction,
      Future<String> Function({required String value}) todo) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Form(
              key: formKey,
              child: AlertDialog(
                  title: Text('New $field'),
                  content: TextFormField(
                    controller: textFieldController,
                    decoration:
                        const InputDecoration(hintText: "Enter Your New Value"),
                    validator: validatorFunction,
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('CANCEL'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                        child: const Text('OK'),
                        onPressed: () {

                          if (formKey.currentState!.validate()) {
                            todo(value: textFieldController.text).then((val) async {

                              // We wait until the future resolves and look at the boolean value returned


                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                   val,
                                  style: myMessageStyle,
                                ),
                                backgroundColor: Color(0xFF94F9E1),
                              ));

                              //We have to wait for the Snackbar to dissappear
                              
                              await Future.delayed(Duration(seconds: 5));

                             Navigator.of(context).pop();


                            }).catchError((error) {
                              print(error);
                            });
                          }
                        }),
                  ]));
        });
  }


}
