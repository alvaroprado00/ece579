import 'dart:io';
import 'dart:math';

import 'package:demo_firebase_login/controller/expert_dao.dart';
import 'package:demo_firebase_login/model/expert.dart';
import 'package:demo_firebase_login/screens/main.dart';
import 'package:demo_firebase_login/screens/util_interface.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiplomaPage extends StatefulWidget{
  @override
  State createState() {
    // TODO: implement createState
    return DiplomaPageState();
  }

}

class DiplomaPageState extends State{
  PickedFile? imageFile=null;
  Future<void>_showChoiceDialog(BuildContext context)
  {
    return showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: Text("Choose option",style: myTextFieldStyle,),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              getMyDivider(),
              ListTile(
                onTap: (){
                  _openGallery(context);
                },
                title: const Text("Gallery"),
                leading: const Icon(Icons.account_box,color: Color(0xFF94F9E1),),
              ),

              getMyDivider(),
              ListTile(
                onTap: (){
                  _openCamera(context);
                },
                title: const Text("Camera"),
                leading: const Icon(Icons.camera,color:Color(0xFF94F9E1),),
              ),
            ],
          ),
        ),);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF94F9E1),
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
        title: Text('Diploma', style: appBarTextStyle,),
      ),

      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                child:( imageFile==null)?Text("Upload a photo of your diploma"): Image.file( File(  imageFile!.path)),
              ),

              ElevatedButton(
                onPressed: (){ _showChoiceDialog(context);},
                style: myButtonStyle,
                child:  Text("Select Image", style: labelStyleForButton,),
              ),

              ElevatedButton.icon(
                onPressed: (){
                  if(this.imageFile!=null){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Creating Expert', style: myMessageStyle,),backgroundColor: Color(0xFF94F9E1),),
                    );
                    createExpert().then((value){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const HomePage(),));
                    });
                  }else{
                    showErrorDialog(context);
                  }
                },
                style: myButtonStyle,
                icon: const Icon(Icons.done, color: Colors.black,),
                label: Text("Done", style: labelStyleForButton,),
              )

            ],
          ),
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery ,
    );
    setState(() {
      imageFile = pickedFile!;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context)  async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera ,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    Navigator.pop(context);
  }


  showErrorDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
      content: Text("Help us verify that you are a verified expert. You need to provide a photo of your diploma so we know you are qualified", style: myMessageStyle,),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<String> createExpert() async {
    //I need to create an object Expert retrieving all the info from sharedPreferences

    SharedPreferences sp= await SharedPreferences.getInstance();

    try{

      String userName= sp.getString('userNameExpert')?? '';
      String email= sp.getString('emailExpert')?? '';
      String password= sp.getString('passwordExpert')?? '';
      String phoneNumber= sp.getString('phoneNumber')?? '';
      int phoneNumberPrefix= sp.getInt('phoneNumberPrefix')?? 0;
      String expertiseAsString= sp.getString('expertise')?? '';
      String description=sp.getString('description')?? '';
      String imageUrl=imageFile!.path;

      //Obtain enum value from String

      Expertise exp= Expert.expertiseFromString(expertiseAsString);

      return addExpert( e: Expert(userName:userName, email:email, phoneNumber: phoneNumber, phoneNumberPrefix: phoneNumberPrefix, expertise: exp,description: description,diplomaUrl: imageUrl ),
      password: password);

    }catch(e) {
      return "Error when getting experts info from Shared Preferences";

    }


  }
}