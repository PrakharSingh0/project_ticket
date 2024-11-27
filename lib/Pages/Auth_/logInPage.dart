// Import Firebase Plugin
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_ticket/service/firebaseAuthService.dart';

// Import Flutter Plugin
import 'package:flutter/material.dart';


class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  String? errorMessage = '';
  bool isLoading = false;
  bool _passwordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> checkCredential() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      // Display error if credentials are empty
      setState(() {
        errorMessage = "Email & Password are required!";
        isLoading = false;
      });
      return;
    }

    try {
      // Attempt to log in
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // On success, navigate to home page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged in successfully')),
      );
      Navigator.popUntil(context, (route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      setState(() {
        errorMessage = e.message ?? "An error occurred.";
        isLoading = false;
      });
    } catch (e) {
      // Handle generic errors
      setState(() {
        errorMessage = "An unexpected error occurred.";
        isLoading = false;
      });
    }
  }

  void _resetErrorMessage() {
    setState(() {
      errorMessage = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/back.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Back Button
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: SizedBox(
                //     width: 120,
                //     child: TextButton(
                //       onPressed: () {
                //         Navigator.pop(context);
                //       },
                //       child: const Row(
                //         children: [
                //           Icon(Icons.arrow_back_rounded, color: Colors.white),
                //           SizedBox(width: 5),
                //           Text("Back", style: TextStyle(color: Colors.white)),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 100),

                // Welcome Message
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Sign in to continue your Crowd Wave experience',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey[300]),
                ),
                const SizedBox(height: 20),

                // Input Fields
                Column(
                  children: [
                    // Email Field
                    TextField(
                      onTap: _resetErrorMessage,
                      style: const TextStyle(color: Colors.white),
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: "example@domain.com",
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    TextField(
                      onTap: _resetErrorMessage,
                      style: const TextStyle(color: Colors.white),
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Colors.white),
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

                // Error Message
                if (errorMessage != null && errorMessage!.isNotEmpty)
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                const SizedBox(height: 10),

                // Login Button
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : checkCredential,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.login, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Log In', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Navigation Options
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?',
                        style: TextStyle(color: Colors.grey[300])),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      child: const Text('Sign Up',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),

                // Forgot Password
                TextButton(
                  onPressed: () {
                  },
                  child: const Text('Forgot Password?',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
