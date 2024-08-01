import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fire_app2/controllers/storage_items.page_ctrl.dart';
import 'package:fire_app2/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class StorageItemsPage extends StatelessWidget {
  const StorageItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final StorageItemsPageCtrl ctrl = Get.put(StorageItemsPageCtrl());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Storage Items"),
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: StorageService().fetchImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(2.w),
              child: Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 20,
                children: [
                  for (Reference image in snapshot.data!.items)
                    FutureBuilder(
                      future: image.getDownloadURL(),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return Container(
                            height: 30.h,
                            width: 36.w,
                            color: Colors.grey[200],
                            child: Image.network(
                              snapshot.data!,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: LinearProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              fit: BoxFit.contain,
                            ),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            height: 30.h,
                            width: 36.w,
                            alignment: Alignment.center,
                            child: const LinearProgressIndicator(),
                          );
                        }
                        return Container();
                      },
                    ),
                ],
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(
            child: Text(
              "Error",
              style: TextStyle(color: Colors.black, fontSize: 100),
            ),
          );
        },
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Item",
        onPressed: () {
          ctrl.uploadImage(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
