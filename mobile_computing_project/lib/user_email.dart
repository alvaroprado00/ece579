import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_computing_project/util.dart';

class UserEmailPage extends StatefulWidget {
  //UserEmailPageWidget({Key key}) : super(key: key);

  @override
  _UserEmailPageState createState() => _UserEmailPageState();
}

class _UserEmailPageState extends State<UserEmailPage> {
  late TextEditingController textController;
 // bool _loadingButton = false;
  final formKey = GlobalKey<FormState>();
  // final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF94F9E1),
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
        title: Text('Email', style: appBarTextStyle,),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                child: Lottie.asset(
                  'lib/assets/lottie_animations/email.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  frameRate: FrameRate(20),
                  animate: true,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(30, 20, 30, 0),
                child: TextFormField(
                  onChanged: (_) => setState(() {}),
                  controller: textController,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Email address',
                    enabledBorder: myUnderlineInputBorderForTextField,
                    focusedBorder: myUnderlineInputBorderForTextField,
                    suffixIcon: textController.text.isNotEmpty
                        ? InkWell(
                      onTap: () => setState(
                            () => textController.clear(),
                      ),
                      child:const Icon(
                        Icons.clear,
                        color: Colors.black,
                        size: 22,
                      ),
                    )
                        : null,
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),

                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val==null|| val.isEmpty) {
                      return 'Field is required';
                    }

                    return null;
                  },
                ),
              ),
              const Spacer(flex: 2),

              SizedBox(
                width: 130,
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if(formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Creating User')),
                      );

                     // createUser();
                    }
                  },

                  style: myButtonStyle,
                  icon:const Icon(
                    Icons.done,
                    size: 15,
                    color: Colors.black,
                  ),
                  label: Text('Enter', style: labelStyleForButton),
                ),
              ),

              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'lib/assets/images/alert.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                      child: Text(
                        'Your email information will never be shared without your consent',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.getFont(
                          'Lato',
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(flex: 7)
            ],
          ),
        ),
      ),
    );
  }
}


