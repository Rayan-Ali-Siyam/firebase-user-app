import 'package:firebase_auth/firebase_auth.dart';

class StorageFolders {
  static const images = "images";

  // Sub-Folder by userUid under [images] folder.
  final uid = FirebaseAuth.instance.currentUser!.uid;
}
