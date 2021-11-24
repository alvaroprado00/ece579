import 'package:flutter/material.dart';

enum Status {
  answered,
  closed,
  unanswered
}

enum Category{
  suicide,
  bullying,
  childAbuse,
  nutrition,
}
/*
class Report{

  //Our report is going to include

  String title;
  String description;
  Category cat;
  var dateAnswered;
  var dateCreated;
  var dateClosed;
  Status status;

  Report.justCreated( [this.status=Status.unanswered, this.dateCreated='No date provided', this.dateAnswered='No date provided', this.dateClosed='No date provided'], {required this.title, required this.description, required this.cat});

}

*/
