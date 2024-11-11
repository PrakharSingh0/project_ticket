// Import Firebase Plugin
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_ticket/service/firebaseAuthService.dart';

// Import Flutter Plugin
import 'package:flutter/material.dart';

// Import Page Route
import 'package:project_ticket/Pages/Auth_/signUpPage.dart';
import 'package:project_ticket/Pages/User_/homePage.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  String? errorMassage = '';
  bool isLogin = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMassage = e.message;
      });
    }
  }

  Widget _errorMassage() {
    return Text(
      errorMassage == '' ? '' : "Humm? $errorMassage",
      style: const TextStyle(color: Colors.red, fontSize: 15),
    );
  }

  // App structure ---------->

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/splashScreen.jpeg"),
                      fit: BoxFit.fitHeight)),
              child: Padding(
                  padding: const EdgeInsets.all(24.0),

                  // Main Structure

                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 120,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Row(children: [
                                  Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                  ),
                                  Text("Back",
                                      style: TextStyle(color: Colors.white)),
                                ]),
                              ),
                            )),
                        const SizedBox(height: 100),
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Sign in to continue your Crowd Wave experience',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[300]),
                        ),
                        const SizedBox(height: 20),

                        // Input Field --------------->

                        Column(
                          children: [
                            const SizedBox(height: 16),

                            // Email ----------------->
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                errorText: Validators.email(
                                    _emailController.text),
                                labelText: 'Email',
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),

                            // Password -------------->
                            const SizedBox(height: 16),
                            TextField(
                              controller: _passwordController,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                errorText: Validators.password(
                                    _passwordController.text),
                                labelText: 'Password',
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        _errorMassage(),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 225,
                          child: ElevatedButton(
                              onPressed: () async {
                                // Handle login
                                final user = await Auth()
                                    .signInWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text);
                                log("user logged in");
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const homePage()));
                                                            },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                textStyle: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: Colors.white,)),
                                  SizedBox(width: 15,),
                                  Text('Log In',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              )),
                        ),
                        const SizedBox(height: 10),
                        const Text('OR', style: TextStyle(color: Colors.white)),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 220,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Handle Google login
                              print('Google login pressed...');
                            },
                            icon: const Icon(Icons.login_outlined,
                                color: Colors.white),
                            label: const Text('Log in with Google',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              side: const BorderSide(
                                  color: Colors.white, width: 2),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',
                                style: TextStyle(color: Colors.grey[300])),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupWidget()));
                                // Navigate to sign-up page
                              },
                              child: const Text('Sign Up',
                                  style: TextStyle(color: Colors.blue)),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle password recovery
                          },
                          child: const Text('Forgot Password?',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ])))),
    );
  }
}

class Validators {
  static password(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Password Required !";
    }
    else {
      return;
    }
  }static email(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Email Required !";
    }
    else {
      return;
    }
  }
}
