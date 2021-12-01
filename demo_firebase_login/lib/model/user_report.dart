import 'dart:core';


class UserReport {
  // to create the report from the user
  String title;
  String category;
  String description;

  UserReport(
      {required this.title, required this.category, required this.description});

  // When we call the database we create the user with this builder from the json

  factory UserReport.fromJson(Map<String, dynamic> json){
    return UserReport(
      title: json['title'],
      category: json['category'],
      description: json['description'],
    );
  }
}