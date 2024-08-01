import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire_app2/constants/firestore_collections.dart';
import 'package:fire_app2/models/item_model.dart';
import 'package:fire_app2/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  addUser(String email) async {
    QuerySnapshot<Map<String, dynamic>> user = await _instance
        .collection(FirestoreCollections.users)
        .where(UserFields.email, isEqualTo: email)
        .get();

    if (user.docs.isEmpty) {
      UserModel newUser = UserModel(email: email, isAdmin: false);
      _instance
          .collection(FirestoreCollections.users)
          .doc(uid)
          .set(newUser.toJson());
    }
  }

  deleteUser(String uid) {
    _instance.collection(FirestoreCollections.users).doc(uid).delete();
  }

  Query<ItemModel> fetchItems() {
    Query<ItemModel> items = _instance
        .collection(FirestoreCollections.users)
        .doc(uid)
        .collection(FirestoreCollections.items)
        .withConverter<ItemModel>(
          fromFirestore: (snapshot, _) => ItemModel.fromJson(snapshot.data()!),
          toFirestore: (item, _) => item.toJson(),
        )
        .orderBy(ItemFields.name);
    return items;
  }

  addItem(String name, String quantity) {
    ItemModel item = ItemModel(name: name, quantity: quantity);
    _instance
        .collection(FirestoreCollections.users)
        .doc(uid)
        .collection(FirestoreCollections.items)
        .add(item.toJson());
  }

  deleteItem(String id) {
    _instance
        .collection(FirestoreCollections.users)
        .doc(uid)
        .collection(FirestoreCollections.items)
        .doc(id)
        .delete();
  }

  // Query<ImageModel> fetchImages() {
  //   Query<ImageModel> images = _instance
  //       .collection(FirestoreCollections.images)
  //       .withConverter<ImageModel>(
  //         fromFirestore: (snapshot, _) => ImageModel.fromJson(snapshot.data()!),
  //         toFirestore: (image, _) => image.toJson(),
  //       )
  //       .orderBy(ImageFields.name);
  //   return images;
  // }

  // addImage(String name, String url) {
  //   ImageModel image = ImageModel(name: name, url: url);
  //   _instance.collection(FirestoreCollections.images).add(image.toJson());
  // }

  // deleteImage(String id) {
  //   _instance.collection(FirestoreCollections.images).doc(id).delete();
  // }
}
