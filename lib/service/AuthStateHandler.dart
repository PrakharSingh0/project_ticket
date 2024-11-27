import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ticket/Pages/User_/homePage.dart';
import 'package:project_ticket/welcome_page.dart';


class AuthStateHandler extends StatelessWidget {
  const AuthStateHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          // User is signed in, show HomePage
          return const homePage();
        } else {
          // No user is signed in, show WelcomePage
          return const welcome_page();
        }
      },
    );
  }
}
