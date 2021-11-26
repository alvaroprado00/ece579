import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase_login/config/config_data.dart';
import 'package:demo_firebase_login/controller/user_dao.dart';
import 'package:demo_firebase_login/screens/user_main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import 'entry_page.dart';
import 'expert_main_page.dart';

enum TypeOfUser { user, expert }

enum ApplicationLoginState {
  loggedIn,
  loggedOut,
}

int counter = 0;
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mentalthy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class ApplicationState extends ChangeNotifier {
  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;
  TypeOfUser typeOfUser = TypeOfUser.user;
  String userId = 'none';

  ApplicationState() {
    init();
  }

  Future<bool> init() async {
    await Firebase.initializeApp();
    //Listen to changes in Auth DB
    FirebaseAuth.instance.userChanges().listen((user) async {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        userId = user.uid;

        // I need to initialize both of them

        await updatedUser();
        await updatedExpert();
        await isUser(uid: user.uid).then((a) {
          if (a == true) {
            typeOfUser = TypeOfUser.user;
          }else{
            typeOfUser= TypeOfUser.expert;
          }
        });
      } else {
        _loginState = ApplicationLoginState.loggedOut;
      }
      notifyListeners();
    });
    return true;
  }

  //Listen To changes in users collection
  Future<void> updatedUser() async {
    FirebaseFirestore.instance
        .collection(userCollectionName)
        .doc(userId)
        .snapshots()
        .listen((val) async {
      notifyListeners();
    });
  }

  //Listen To changes in Expert collection
  Future<void> updatedExpert() async {
    FirebaseFirestore.instance
        .collection(expertCollectionName)
        .doc(userId)
        .snapshots()
        .listen((val) async {
      notifyListeners();
    });
  }


}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Our Home page needs to be hearing the AppState

    return Consumer<ApplicationState>(builder: (context, appState, _) {
      if (counter == 0) {
         counter++;
        return FutureBuilder(
          future: appState.init(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              counter++;
              return ContentOfHomePage(
                  loginState: appState.loginState,
                  typeOfUser: appState.typeOfUser);
            } else if (snapshot.hasError) {
              return const MySplashScreen();
            } else {
              return const MySplashScreen();
            }
          },
        );
      } else {
        return ContentOfHomePage(
            loginState: appState.loginState, typeOfUser: appState.typeOfUser);
      }
    });
  }
}

class ContentOfHomePage extends StatelessWidget {
  const ContentOfHomePage(
      {Key? key, required this.loginState, required this.typeOfUser})
      : super(key: key);

  final ApplicationLoginState loginState;
  final TypeOfUser typeOfUser;

  //There are going to be 3 situations:
  // Sit 1: User/Exp not logged in => Show original screen
  // Sit 2 : User logged in => Show home of user
  // Sit 3 : Expert logged in => Show home of Expert

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedOut:
        return const EntryPage();
      case ApplicationLoginState.loggedIn:
        if (typeOfUser == TypeOfUser.user) {
          return HomeUser();
        } else {
          return HomeExpert();
        }
    }
  }
}

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF94F9E1),
      body: SafeArea(
          child: Align(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 30),
            child: Text(
              'Loading',
              style: GoogleFonts.getFont(
                'Lato',
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          Image.asset(
            'assets/images/happy_mV2.png',
            width: 200,
            height: 200,
          ),
          const CircularProgressIndicator(
            color: Colors.black,
          )
        ]),
      )),
    );
  }
}
