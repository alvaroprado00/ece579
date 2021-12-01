import 'dart:core';


class UserCustom{

  //I have read in some forums that you should not keep the password anywhere besides the auth DB

  String userName;
  String email;

  UserCustom({required this.userName, required this.email});

  // When we call the database we create the user with this builder from the json

  factory UserCustom.fromJson(Map<String, dynamic> json){
    return UserCustom(
      userName: json['userName'],
      email: json['email'],
    );
  }




}