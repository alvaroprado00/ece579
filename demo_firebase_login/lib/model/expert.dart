
import 'dart:core';

enum Expertise{
  bullying,
  child_abuse,
  nutrition,
  suicide
}

class Expert {

// I am not using the password here

  String userName;
  String email;
  String phoneNumber;
  int phoneNumberPrefix;
  String description;
  Expertise expertise;
  String diplomaUrl;

  Expert(
      {required this.userName, required this.email, required this.phoneNumber, required this.phoneNumberPrefix, required this.description, required this.expertise, required this.diplomaUrl });


  factory Expert.fromJson(Map<String, dynamic> json){
    return Expert(
        userName: json['userName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        phoneNumberPrefix: json['prefixPhoneNumber'],
        description: json['description'],
        expertise: json['expertise'],
        diplomaUrl: json['diplomaUrl']
    );
  }


}