import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iplik/util/models/account.dart';
import 'package:iplik/util/models/lif.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Utilites {
  static Future<void> createAccount(Account account) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection("users").doc(
      FirebaseAuth.instance.currentUser!.uid
    ).set(account.toJson());
  }

  static void showSnackbar({
    required bool isSuccess,
    required String title,
    required String description
  }) {
    Get.snackbar(
      title,
      description,
      icon: isSuccess
        ? const Icon(Icons.check, color: Colors.green)
        : const Icon(Icons.warning_amber, color: Colors.red)
    );
  }

  static void showLoadingDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Container(
          color: Colors.black.withOpacity(.5),
          child: const Center(child: CupertinoActivityIndicator())
        );
      },
    );
  }

  static Future<List<Lif>> getNewestLifs() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<Lif> lifs = [];
    List<QueryDocumentSnapshot> docs = (await db.collection("lifs").get()).docs;

    for (QueryDocumentSnapshot snapshot in docs) {
      lifs.add(Lif.fromJson(snapshot.data() as Map<String, dynamic>));
    }

    return lifs;
  }

  static Future<List<Lif>> getTitleLifs(String titleId) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<Lif> lifs = [];
    try {
      Map<String, dynamic> docs = (await db.collection("titles").doc(titleId).get()).data()!;
      List<dynamic> lifsMap = docs["lifs"];

      for (Map<String, dynamic> data in lifsMap) {
        lifs.add(Lif.fromJson(data));
      }

      return lifs;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<List<Lif>> getUserLifs(String uid) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<Lif> lifs = [];
    try {
      Map<String, dynamic> docs = (await db.collection("users").doc(uid).get()).data()!;
      List<dynamic> lifsMap = docs["lifs"];

      for (Map<String, dynamic> data in lifsMap) {
        lifs.add(Lif.fromJson(data));
      }

      return lifs;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}