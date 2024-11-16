// Import Firebase Plugins
import 'package:firebase_core/firebase_core.dart';
import 'package:project_ticket/welcome_page.dart';
import 'firebase_options.dart';

// Import Flutter plugin
import 'package:flutter/material.dart';

// Import Page Route

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: welcome_page(),
    ),
  ); //runApp
}

