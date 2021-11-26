
import 'dart:core';

enum Expertise{
  bullying,
  child_abuse,
  nutrition,
  suicide
}


class Expert {

// I am not using the password here

  late String userName;
  late String email;
  late String phoneNumber;
  late int phoneNumberPrefix;
  late String description;
  late Expertise expertise;
  late String diplomaUrl;

  Expert(
      {required this.userName, required this.email, required this.phoneNumber, required this.phoneNumberPrefix, required this.description, required this.expertise, required this.diplomaUrl });


  Expert.fromJson(Map<String, dynamic> json){
      userName= json['userName'];
      email=json['email'];
      phoneNumber= json['phoneNumber'];
      phoneNumberPrefix= json['phoneNumberPrefix'];
      description= json['description'];
      expertise= expertiseFromString(json['expertise']);//We have to translate the String of the Json into the enum value
      diplomaUrl= json['diplomaUrl'];
  }

  static Expertise expertiseFromString(String value){

   List<Expertise> expertiseList= Expertise.values;

   for (Expertise e in expertiseList){
     if(value.toUpperCase()==e.toString().toUpperCase()){
       return e;
     }
   }
   return Expertise.bullying;
  }

}