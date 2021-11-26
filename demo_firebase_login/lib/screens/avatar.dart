/*
  Class to create a rounded Avatar by calling an specific url
  The avatar created depends on what you append at the end of the url, I used the userName
  This code has being copied from github

 */
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Avatar extends StatefulWidget {
  Avatar({required this.url, required this.size});
  final String url;
  final double size;
  @override
  State<StatefulWidget> createState() => new _AvatarState();
}

class _AvatarState extends State<Avatar> {
  Future<Uint8List> fetchAvatar() async {
    http.Response response = await http.get(Uri.parse(widget.url));
    return response.bodyBytes;
  }

  Widget loadingWidget() {
    return FutureBuilder<Uint8List>(
      future: fetchAvatar(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(snapshot.data?? Uint8List(8));
        } else if (snapshot.hasError) {
          print('${snapshot.error}');
          return const Center(
              child: Text('❌', style: TextStyle(fontSize: 72.0)));
        } else {
          return Container(
            padding: EdgeInsets.all((widget.size - 50.0) / 2.0),
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,

          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black12,
              ])),
      child: ClipOval(
        child: loadingWidget(),
      ),
    );
  }
}