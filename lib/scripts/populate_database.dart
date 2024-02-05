import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class PopulateDatabase {
  static Future<void> populateDatabase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // authentication
    await auth.signInWithEmailAndPassword(email: 'tainassluz@gmail.com', password: '123456');

    // populate physical-activities collection
    String path = 'assets/jsons/physical_activities.json';
    String input = await rootBundle.loadString(path);
    Map<String, dynamic> map = jsonDecode(input);

    for (var pA in (map['physical-activities'] as List)) {
      String id = DateTime.now().microsecondsSinceEpoch.toString();
      await firestore.collection('physical-activities').doc(id).set(pA);
    }
  }
}
