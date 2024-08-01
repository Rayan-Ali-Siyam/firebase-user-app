import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fire_app2/controllers/home_page_ctrl.dart';
import 'package:fire_app2/views/firestore_items_page.dart';
import 'package:fire_app2/views/storage_items_page.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<User?>? listener;
  @override
  void initState() {
    listener = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/sign-in",
          (Route<dynamic> route) => false,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    listener!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomePageCtrl ctrl = Get.put(HomePageCtrl());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: PageView(
        controller: ctrl.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          FirestoreItemsPage(),
          StorageItemsPage(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: ctrl.selectedIndex.value,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.storage_outlined),
              label: "Firestore",
            ),
            NavigationDestination(
              icon: Icon(Icons.image_outlined),
              label: "Storage",
            ),
          ],
          onDestinationSelected: (index) => ctrl.onDestinationSelected(index),
        ),
      ),
    );
  }
}
