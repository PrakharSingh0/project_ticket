// Import Firebase Plugin
import 'dart:async';

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
  bool isLoading = false;
  int delayTime = 500;

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

  Future<void> checkCredential() async {
    setState(() {
      isLoading = true;
    });

    if (_emailController.text == "" || _passwordController.text == "") {
      Timer(Duration(milliseconds: delayTime), () {
        errorMassage = "Both Email & Password Required";
        _emailController.clear();
        _passwordController.clear();
        setState(() {
          isLoading = false;
        });
      });
    } else {
      final user = await Auth()
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .onError(
        (error, stackTrace) {
          _resetErrorMessage();
          errorMassage = "Incorrect Credentials";
          _emailController.clear();
          _passwordController.clear();
          setState(() {
            isLoading = false;
          });
          return null;
        },
      );

      if (Auth().currentUser != null) {
        Timer(Duration(milliseconds: delayTime), () {
          setState(() {
            isLoading = false;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const homePage()));
        });
      }
    }
  }

  void _resetErrorMessage() {
    setState(() {
      errorMassage = "";
    });
  }

  // App structure ---------->

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
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
                          Text("Back", style: TextStyle(color: Colors.white)),
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
                  style: TextStyle(fontSize: 18, color: Colors.grey[300]),
                ),
                const SizedBox(height: 20),

                // Input Field --------------->

                Column(
                  children: [
                    const SizedBox(height: 16),

                    // Email ----------------->
                    TextField(
                      onTap: () {
                        _resetErrorMessage();
                      },
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: "Team001@droid.com",
                        // errorText: errorMassage,
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),

                    // Password -------------->
                    const SizedBox(height: 16),
                    TextField(
                      onTap: () {
                        _resetErrorMessage();
                      },
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Colors.white),
                        // errorText: errorMassage,
                        labelText: 'Password',
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

                    const SizedBox(height: 10),
                    Text(
                      errorMassage!,
                      style: const TextStyle(
                          color: Colors.red, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Handle login
                          checkCredential();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          textStyle: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 20,
                                child: CircularProgressIndicator(),
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Log In',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // const Text('OR', style: TextStyle(color: Colors.white)),
                    // const SizedBox(height: 10),
                    // SizedBox(
                    //   width: 220,
                    //   child: ElevatedButton.icon(
                    //     onPressed: () {
                    //       // Handle Google login
                    //       print('Google login pressed...');
                    //     },
                    //     icon: const Icon(Icons.login_outlined,
                    //         color: Colors.white),
                    //     label: const Text('Log in with Google',
                    //         style: TextStyle(color: Colors.white)),
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.transparent,
                    //       side: const BorderSide(color: Colors.white, width: 2),
                    //       padding: const EdgeInsets.symmetric(
                    //           vertical: 16, horizontal: 32),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(28),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Validators {
  static password(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Password Required !";
    } else {
      return;
    }
  }

  static email(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Email Required !";
    } else {
      return;
    }
  }
}
