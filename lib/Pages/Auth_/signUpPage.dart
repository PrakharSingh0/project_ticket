import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  String? errorMessage = '';
  bool isLoading = false;

  // Text Field Controllers
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
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Navigate to HomePage on successful signup
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account Created Successfully')),
      );
      Navigator.popUntil(context, (route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "An error occurred";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool validateInputs() {
    final emailError = Validators.email(_emailController.text);
    final passwordError = Validators.password(_passwordController.text);
    final usernameError = Validators.username(_userNameController.text);

    if (emailError != null) {
      setState(() {
        errorMessage = emailError;
      });
      return false;
    }
    if (passwordError != null) {
      setState(() {
        errorMessage = passwordError;
      });
      return false;
    }
    if (usernameError != null) {
      setState(() {
        errorMessage = usernameError;
      });
      return false;
    }

    return true;
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
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: TextButton.icon(
                //     onPressed: () => Navigator.pop(context),
                //     icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                //     label: const Text("Back", style: TextStyle(color: Colors.white)),
                //   ),
                // ),
                const SizedBox(height: 100),
                const Text(
                  'Join Crowd Wave',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  'Create your account and start experiencing live events like never before',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey[300]),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    TextField(
                      controller: _userNameController,
                      decoration: const InputDecoration(
                        labelText: 'User Name',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'xyz-123@gmail.com',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.white),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : () {
                      if (validateInputs()) {
                        createUserWithEmailAndPassword();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Sign Up',style: TextStyle(color: Colors.white),),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?', style: TextStyle(color: Colors.grey[300])),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text('Log In', style: TextStyle(color: Colors.blue)),
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
  static String? email(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Email is required!";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(txt)) {
      return "Enter a valid email!";
    }
    return null;
  }

  static String? password(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Password is required!";
    } else if (txt.length < 6) {
      return "Password must be at least 6 characters!";
    }
    return null;
  }

  static String? username(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "User Name is required!";
    }
    return null;
  }
}
