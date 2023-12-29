import 'main/index.dart';
import 'package:flutter/material.dart';
import 'main/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  initializeFirebase();
  runApp(MaterialApp(
    home: const Index(),
    routes: routes,
  ));
}

initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
