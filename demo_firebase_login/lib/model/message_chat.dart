import 'dart:core';



class MessageChat{
  String UserID;
  //String ExpertID;
  String ReportID;
  List<String> Chat;


  MessageChat(
      {required this.UserID, /*required this.ExpertID,*/ required this.ReportID, required this.Chat}
      );

  factory MessageChat.fromJson(Map<String, dynamic> json){
    return MessageChat(
      UserID: json['uid'],
      //ExpertID: json['expertId'],
      ReportID: json['reportId'],
      Chat: json['chat'],
    );
  }
}