// Import Firebase Plugin
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_ticket/service/firebaseAuthService.dart';

// Import Flutter Plugin
import 'package:flutter/material.dart';

// Import Page route
import 'package:project_ticket/Pages/Auth_/logInPage.dart';

import '../User_/dashboard.dart';


class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {

  String? errorMassage ='';
  bool isLogin =true;

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


  Future<void> createUserWithEmailAndPassword() async{
    try{
      await Auth().createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException
    catch(e){
      setState(() {
        errorMassage=e.message;
      });
    }
  }

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
                  fit: BoxFit.fitHeight)
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      controller: _userNameController,
                      decoration: InputDecoration(
                        labelText: 'UserName',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                          const BorderSide(color: Colors.transparent),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.white),
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

                // _buildTextField(_userNameController, 'UserName', false),
                // _buildTextField(_emailController, 'Email', false,
                //     TextInputType.emailAddress),
                // _buildTextField(_passwordController, 'Password', true),

                const SizedBox(height: 10),
                SizedBox(
                  width: 225,
                  child: ElevatedButton(
                    onPressed: () async {
                      final user =await Auth().createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                      await Auth().currentUser?.updateDisplayName(_userNameController.text);
                      if (User != null) {
                        print("user logged in");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const dasboard()));
                      }

                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                    ),
                    child: const Text('Sign Up',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('OR', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 10),
                SizedBox(
                  width: 225,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print('Sign up with Google pressed ...');
                    },
                    icon: const Icon(Icons.login_outlined, color: Colors.white),
                    label: const Text('Sign up with Google',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                    ),
                  ),
                ),
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

  // Text Field -------------->

  Widget _buildTextField(
      TextEditingController controller, String label, bool isPassword,
      [TextInputType? keyboardType]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !_passwordVisible,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.white.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(_passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : null),
      ),
    );
  }
}
