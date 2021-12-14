import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




/* TODO add the date when report created */
class UserReport {
  // to create the report from the user
  String uId; //need to get user ID
  String title;
  String category;
  String description;
  List<String> chat;
  String date;

  UserReport(
      {required this.title, required this.category, required this.description, required this.uId, required this.chat, required this.date}
      );

  // When we call the database we create the user with this builder from the json

  factory UserReport.fromJson(Map<String, dynamic> json){
    return UserReport(
      title: json['title'],
      category: json['category'],
      description: json['description'],
      uId: json['uId'],
      chat: json['chat'],
      date: json['date'],
    );
  }
}