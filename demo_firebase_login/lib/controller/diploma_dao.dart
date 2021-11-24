
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'dart:io';


Future<void> addDiplomaToStorage(String filePath) async {
  File file = File(filePath);
  String nameOfFile= basename(filePath);
  try {
    await firebase_storage.FirebaseStorage.instance
        .ref('uploads/$nameOfFile')
        .putFile(file);
  } on FirebaseException catch (e) {
    // e.g, e.code == 'canceled'
  }
}