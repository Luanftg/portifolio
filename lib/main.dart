import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portifolio/firebase_options.dart';
import 'package:portifolio/my_app.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
