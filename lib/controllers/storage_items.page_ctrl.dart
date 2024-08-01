
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fire_app2/services/storage_service.dart';
import 'package:get/get.dart';

class StorageItemsPageCtrl extends GetxController {
  RxDouble downloadProgress = 0.0.obs;

  uploadImage(BuildContext context) async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ["png", "jpg"],
    );

    if (results == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No file selected"),
          ),
        );
      }
      return;
    }

    String fileName = results.files.single.name;
    String filePath = results.files.single.path!;

    if (context.mounted) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Dialog(
              child: Obx(
                () => LinearProgressIndicator(value: downloadProgress.value),
              ),
            );
          });
    }

    StorageService().upload(fileName, filePath).snapshotEvents.listen((event) {
      downloadProgress.value =
          event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
      if (event.state == TaskState.success) {
        Get.back();
        downloadProgress.value = 0;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("File added to the Storage"),
          ),
        );
      }
    }).onError((error) {
      // do something to handle error
    });
  }
}
