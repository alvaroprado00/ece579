import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class MessageList extends StatelessWidget {
  //const MessageList({Key? key}) : super(key: key);
  final String reportID;
  MessageList(this.reportID);
  final CollectionReference reportMessage = FirebaseFirestore.instance.collection("reports");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: reportMessage.doc(reportID).collection('subchat').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return(Text('error fetching messages'));
          }
            if(snapshot.hasData){
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return SingleChildScrollView(
                child: (
                    Column(
                      children: documents.map((doc) =>
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Expanded(
                              child: Text('${doc['messageContent']}',),
                            ),
                                Text('${doc['userName']}'),
                          ]
                          ),
                      ).toList(),
                    )
                ),
              );
            }
            else{
              return( Text("Loading..."));
          }

        }
    );
  }
}
