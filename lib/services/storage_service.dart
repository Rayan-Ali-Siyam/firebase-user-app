import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fire_app2/constants/storage_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<ListResult> fetchImages() async {
    ListResult results = await storage
        .ref("${StorageFolders.images}/${StorageFolders().uid}")
        .listAll();

    return results;
  }

  UploadTask upload(String fileName, String filePath) {
    File file = File(filePath);

    return storage
        .ref(
            '${StorageFolders.images}/${FirebaseAuth.instance.currentUser!.uid}/$fileName')
        .putFile(file);

    // TODO: Need to remove below functions cause Firestore image reference not needed!
    // FirestoreService().addImage(
    //     fileName, '${storage.bucket + StorageFolders.images}/$fileName');
  }

  Future<void> uploadFilefromWeb(
    String fileName,
    Uint8List fileBytes,
  ) async {
    // File file = File(filePath);

    try {
      await storage
          .ref(
              '${StorageFolders.images}/${FirebaseAuth.instance.currentUser!.uid}/$fileName')
          .putData(fileBytes);

      // TODO: Need to remove below functions cause Firestore image reference not needed!
      // FirestoreService().addImage(
      //     fileName, '${storage.bucket + StorageFolders.images}/$fileName');
    } on FirebaseException catch (_) {}
  }

  Future<String> downloadImage(String imageName) async {
    String downloadUrl = await storage
        .ref("${StorageFolders.images}/${StorageFolders().uid}/$imageName")
        .getDownloadURL();

    return downloadUrl;
  }
}
