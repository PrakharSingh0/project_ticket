// Import Firebase Plugins
import 'package:firebase_core/firebase_core.dart';
import 'package:project_ticket/service/AuthStateHandler.dart';
import 'Pages/Auth_/logInPage.dart';
import 'Pages/Auth_/signUpPage.dart';
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
    MaterialApp(
      routes: {
        '/login': (context) => const LoginPageWidget(),
        '/signup': (context) => const SignupWidget(),
      },
      debugShowCheckedModeBanner: false,
      home: const AuthStateHandler(),
    ),
  ); //runApp
}

