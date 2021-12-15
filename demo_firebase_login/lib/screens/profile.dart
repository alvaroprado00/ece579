import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase_login/controller/auth_dao.dart';
import 'package:demo_firebase_login/controller/expert_dao.dart';
import 'package:demo_firebase_login/controller/user_dao.dart';
import 'package:demo_firebase_login/model/expert.dart';
import 'package:demo_firebase_login/model/user_custom.dart';
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:demo_firebase_login/screens/util_logic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'avatar.dart';
import 'main.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
        builder: (context, appState, _) =>
            GetInfo(userId: appState.userId, typeOfUser: appState.typeOfUser));
  }
}

class GetInfo extends StatelessWidget {
  String userId;
  TypeOfUser typeOfUser;
  Future<DocumentSnapshot<Object?>> Function({required String uid})
      functionToCallFuture = getActiveExpert;

  GetInfo({Key? key, required this.userId, required this.typeOfUser})
      : super(key: key);

  //This is to have the active user as our Object UserCustom to have all the the info in this page
  @override
  Widget build(BuildContext context) {
    if (typeOfUser == TypeOfUser.user) {
      functionToCallFuture = getActiveUser;
    }
    return FutureBuilder<DocumentSnapshot>(
        future: functionToCallFuture(uid: userId),
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
            if (TypeOfUser.user == typeOfUser) {
              UserCustom uc = UserCustom.fromJson(data);
              return infoFromUser(
                user: uc,
                expert: null,
              );
            } else {
              Expert e = Expert.fromJson(data);
              return infoFromUser(user: null, expert: e);
            }
          }

          return const MySplashScreen();
        });
  }
}

class infoFromUser extends StatelessWidget {
  //In this widget we can display whatever info we want from the active user

  UserCustom? user;
  Expert? expert;
  String urlCustom = 'none';
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  //I define here all the functions that are going to be used supposing a user is using this page

  Future<String> Function({required String value}) functionToUpdateUserName =
      updateUserNameForUser;
  Future<String> Function({required String value}) functionToUpdateEmail =
      updateEmailForUser;

  infoFromUser({Key? key, required this.user, required this.expert})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Here we check if it is actually an expert and change the values
    if (expert == null) {
      urlCustom = 'https://robohash.org/${user!.userName}';
    } else {
      urlCustom = 'https://robohash.org/${expert!.userName}?set=set5';
      functionToUpdateUserName = updateUserNameForExpert;
      functionToUpdateEmail = updateEmailForExpert;
    }

    return Scaffold(
      key: _scaffoldkey,
      appBar: getCustomAppBar(text: 'Your profile info'),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //AVATAR

              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 30),
                child: Avatar(
                  url: urlCustom,
                  size: 200,
                ),
              ),

              //USER NAME
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 40),
                child: Text(
                  'Hi, ${user?.userName ?? expert?.userName}',
                  style: GoogleFonts.getFont('Lato', fontSize: 30),
                ),
              ),
              getMyDivider(),

              //ALL THE DIFFERENT FIELDS

              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                child: fieldModifier(
                    message: 'User Name: ${user?.userName ?? expert?.userName}',
                    icon: Icons.mode_outlined,
                    colorOfIcon: Colors.black,
                    todo: () {
                      displayTextInputDialog(context, 'User Name',
                          validatorForNotEmpty, functionToUpdateUserName);
                    }),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                child: fieldModifier(
                    message: 'Email: ${user?.email ?? expert?.email}',
                    icon: Icons.mode_outlined,
                    colorOfIcon: Colors.black,
                    todo: () {
                      displayTextInputDialog(context, 'Email',
                          validatorForEmail, functionToUpdateEmail);
                    }),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                child: fieldModifier(
                    message: 'Password: ************',
                    icon: Icons.mode_outlined,
                    colorOfIcon: Colors.black,
                    todo: () {
                      displayTextInputDialog(context, 'Password',
                          validatorForPassword, updatePasswordAuthDb);
                    }),
              ),

              getExtraWidget1(expert, context),
              getExtraWidget2(expert, context),

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
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  void deleteAccountFromUserProfile(BuildContext context) {
    //Call the function on the user dao

    deleteUserAccount().then((val) async {
      //I show a message to notify if everything went OK or if the user has not been deleted
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          val,
          style: myMessageStyle,
        ),
        backgroundColor: Color(0xFF94F9E1),
      ));

      //We have to wait for the Snackbar to dissappear

      await Future.delayed(Duration(seconds: 5));

      //Then navigate to entry point and clean stack
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
              (Route<dynamic> route) => route is HomePage
      );
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
                            todo(value: textFieldController.text)
                                .then((val) async {
                              // We wait until the future resolves and look at the boolean value returned

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  val,
                                  style: myMessageStyle,
                                ),
                                backgroundColor: const Color(0xFF94F9E1),
                              ));

                              //We have to wait for the Snackbar to dissappear

                              await Future.delayed(const Duration(seconds: 3));

                              Navigator.of(context).pop();
                            }).catchError((error) {
                              print(error);
                            });
                          }
                        }),
                  ]));
        });
  }

  Widget getExtraWidget1(Expert? expert, BuildContext context) {
    if (expert == null) {
      return const SizedBox(
        height: 1,
        width: 1,
      );
    } else {
      return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
        child: fieldModifier(
            message: 'Phone: ${expert.phoneNumber}',
            icon: Icons.mode_outlined,
            colorOfIcon: Colors.black,
            todo: () {
              displayTextInputDialog(
                  context, 'Phone', validatorForPhone, updatePhoneForExpert);
            }),
      );
    }
  }

  Widget getExtraWidget2(Expert? expert, BuildContext context) {
    if (expert == null) {
      return const SizedBox(
        height: 1,
        width: 1,
      );
    } else {
      return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
        child: fieldModifierWithContext(
            message: 'Prefix: ${expert.phoneNumberPrefix}',
            icon: Icons.mode_outlined,
            colorOfIcon: Colors.black,
            todo: getDropDownDialog,
          context: context,
      ));
    }
  }
}
final formKey = GlobalKey<FormState>();
String dropDownValue='(Spain) +34';

Future<void> getDropDownDialog(BuildContext context)async {
    showDialog(
          context: context,
          builder: (context) {
            return Form(
                key: formKey,
                child: StatefulBuilder(
                  builder:(context, setState) {
                    return AlertDialog(
                        title: Text('New Prefix'),
                        content: DropdownButton(
                          value: dropDownValue,
                          items: <String>[
                            '(Spain) +34',
                            '(US) +1',
                            '(France) +33'
                          ]
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
                                  updatePrefixForExpert(value: dropDownValue)
                                      .then((val) async {
                                    // We wait until the future resolves and show to the user the message in a SnackBar
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        val,
                                        style: myMessageStyle,
                                      ),
                                      backgroundColor: const Color(0xFF94F9E1),
                                    ));

                                    //We wait for the Snackbar to dissappear
                                    await Future.delayed(Duration(seconds: 3));
                                    Navigator.of(context).pop();
                                  }).catchError((error) {
                                    print(error);
                                  });
                                }
                              }),
                        ]);

                  }
                ));
          });
    }


