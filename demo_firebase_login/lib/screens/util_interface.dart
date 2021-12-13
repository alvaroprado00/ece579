import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final myButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF94F9E1)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
);

final myButtonStyleEmergency = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(const Color(0x00ff0000)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
);

final myButtonAuthoritiesStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(const Color(000000)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
);

final myRoundedButtonStyle=ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF94F9E1)),
  shape: MaterialStateProperty.all<CircleBorder>(
      const CircleBorder()
  ),
);

final labelStyleForButton = GoogleFonts.getFont(
  'Lato',
  color: Colors.black,
  fontSize: 20,
);


final myHintStyle = GoogleFonts.getFont(
  'Lato',
  color: Colors.black,
  fontSize: 15,
);

final myTextFieldStyle = GoogleFonts.getFont(
  'Lato',
  color: Colors.black,
  fontSize: 15,
);

final myDropDownButtonStyle= GoogleFonts.getFont(
  'Lato',
  color: Colors.black,
  fontSize: 15,
);

final myMessageStyle=GoogleFonts.getFont(
'Lato',
color: Colors.black,
fontSize: 15,
);

const myUnderlineInputBorderForTextField = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.black,
    width: 2,
  ),
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(4.0),
    topRight: Radius.circular(4.0),
  ),
);

final appBarTextStyle = GoogleFonts.getFont(
  'Lato',
  color: Colors.black,
  fontSize: 20,
);

// Generated code for this Row Widget...
final myProgressionIndicator = Align(
  alignment: const AlignmentDirectional(0, 0),
  child: Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: const Color(0xFFE5D9FF),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
          ),
        ),
      ),
      Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
          ),
        ),
      ),
      Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
          ),
        ),
      )
    ],
  ),
);


Container getRoundedIcon({required IconData icon}){
  return Container(
    width: 75,
    height: 75,
    decoration: const BoxDecoration(
      color: Color(0xFF94F9E1),
      shape: BoxShape.circle,
    ),
    child:Icon(
      icon,
      color: Colors.black,
      size: 44,
    ),
  );
}

Widget getMyDivider(){
  return const Divider(
    height: 1,
    thickness: 1,
    indent: 10,
    endIndent: 10,
    color: Colors.black,
  );
}


Row fieldModifier({required String message, required IconData icon, required Color colorOfIcon, required Function todo}){
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        message,
        style: myTextFieldStyle,
      ),
      IconButton(
        icon: Icon(icon),
        color: colorOfIcon,
        onPressed: () {
          todo();
        },
      ),
    ],
  );
}

Row fieldModifierWithContext({required String message, required IconData icon, required Color colorOfIcon, required Function todo, required BuildContext context}){
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        message,
        style: myTextFieldStyle,
      ),
      IconButton(
        icon: Icon(icon),
        color: colorOfIcon,
        onPressed: () {
          todo(context);
        },
      ),
    ],
  );
}

AppBar getCustomAppBar({required String text}) {
  return AppBar(
    backgroundColor: const Color(0xFF94F9E1),
    iconTheme: const IconThemeData(color: Colors.black),
    automaticallyImplyLeading: true,
    actions: [],
    centerTitle: true,
    elevation: 4,
    title: Text(text, style: appBarTextStyle,),
  );
}

SizedBox getCustomTextFormField({required TextEditingController textController, required bool obscureText, required String hintText, required String? Function(String?)? validationFunction, required IconData icon}){
  return SizedBox(
    width: 285,
    height: 40,
    child: Stack(
      children: [
        TextFormField(
          controller: textController,
          obscureText: obscureText,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: myHintStyle,
              enabledBorder: myUnderlineInputBorderForTextField,
              focusedBorder: myUnderlineInputBorderForTextField
          ),
          style: myTextFieldStyle,
          textAlign: TextAlign.start,
          validator: validationFunction,
        ),
        Align(
          alignment: const AlignmentDirectional(1, 0.1),
          child: Icon(
            icon,
          color: Colors.black,
          size: 24,
        ),
        ),
      ],
    ),
  );
}

