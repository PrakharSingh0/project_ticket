// Import Firebase Plugin
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_ticket/service/firebaseAuthService.dart';

// Import Flutter Plugin
import 'package:flutter/material.dart';

// Import Page route
import 'package:project_ticket/Pages/Auth_/logInPage.dart';

import '../User_/homePage.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  String? errorMassage = '';
  bool isLogin = true;
  bool isLoading = false;
  int delayTime = 500;

  // Text Field Controller
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
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
        errorMassage = "All Credential Required";
        _emailController.clear();
        _passwordController.clear();
        setState(() {
          isLoading = false;
        });
      });
    } else {
      final user = await Auth()
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .onError(
        (error, stackTrace) {
          _resetErrorMessage();
          errorMassage = "Something Went Wrong ! Try Again";
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
                const SizedBox(height: 100), // Spacer
                const Text(
                  'Join Crowd Wave',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  'Create your account and start experiencing live events like never before',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey[300]),
                ),
                const SizedBox(height: 20),

                // Input Text Field ------------->

                Column(
                  children: [
                    TextField(
                      onTap: () {
                        _resetErrorMessage();
                      },
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: _userNameController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: "Name",
                        // errorText: errorMassage,
                        labelText: 'UserName',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
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
                        hintText: "xyz-123@gmail.com",
                        // errorText: errorMassage,
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
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
                  ],
                ),

                const SizedBox(height: 10),
                Text(
                  errorMassage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
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
                      textStyle:
                          const TextStyle(fontSize: 16, color: Colors.white),
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
                              Text('Sign Up',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                  ),
                ),

                // const SizedBox(height: 10),
                // const Text('OR', style: TextStyle(color: Colors.white)),
                // const SizedBox(height: 10),
                // SizedBox(
                //   width: 225,
                //   child: ElevatedButton.icon(
                //     onPressed: () {
                //       print('Sign up with Google pressed ...');
                //     },
                //     icon: const Icon(Icons.login_outlined, color: Colors.white),
                //     label: const Text('Sign up with Google',
                //         style: TextStyle(color: Colors.white)),
                //     style: ElevatedButton.styleFrom(
                //       padding: const EdgeInsets.symmetric(
                //           vertical: 16, horizontal: 32),
                //       backgroundColor: Colors.grey[800],
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(28)),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                        style: TextStyle(color: Colors.grey[300])),
                    TextButton(
                      onPressed: () {
                        print('Navigate to Login ...');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPageWidget()));
                      },
                      child: const Text('Log In',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
                const Text(
                  'By signing up, you agree to our Terms and Privacy Policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.white30),
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
  static email(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Email Required !";
    } else {
      return;
    }
  }

  static password(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Password Required !";
    } else {
      return;
    }
  }

  static username(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Password Required !";
    } else {
      return;
    }
  }
}
