import 'package:flutter/material.dart';
import 'package:fire_app2/models/item_model.dart';
import 'package:fire_app2/services/firestore_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:sizer/sizer.dart';

class FirestoreItemsPage extends StatefulWidget {
  const FirestoreItemsPage({super.key});

  @override
  State<FirestoreItemsPage> createState() => _FirestoreItemsPageState();
}

class _FirestoreItemsPageState extends State<FirestoreItemsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firestore Items"),
        centerTitle: false,
      ),
      body: FirestoreListView<ItemModel>(
        query: FirestoreService().fetchItems(),
        itemBuilder: (context, snapshot) {
          ItemModel item = snapshot.data();

          return Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (c) {
                    FirestoreService().deleteItem(snapshot.id);
                  },
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                  label: "Delete",
                  spacing: 8,
                ),
              ],
            ),
            child: ListTile(
              title: Text(item.name ?? "Null"),
              subtitle: Text(item.quantity ?? 'Null'),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Text("Add items to see here."),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Item",
        onPressed: showItemDialog,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  // showingDialog for creating Item.
  showItemDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: 40.h,
            width: 30.w,
            padding: EdgeInsets.all(5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Item details",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(hintText: "Description"),
                ),
                TextButton(
                  onPressed: () {
                    var name = nameController.text.trim();
                    var quantity = quantityController.text.trim();
                    FirestoreService().addItem(name, quantity);
                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
