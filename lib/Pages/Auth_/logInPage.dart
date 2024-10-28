import 'package:flutter/material.dart';
import 'package:project_ticket/Pages/Auth_/signUpPage.dart';
import 'package:project_ticket/Pages/User_/dashboard.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;



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
            padding: const EdgeInsets.all(20.0),
            child: Column(
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
                          Icon(Icons.arrow_back_rounded,color: Colors.white,),
                          Text("Back",style: TextStyle(color: Colors.white)),
                        ]),
                      ),
                    )),
                SizedBox.fromSize(size: const Size.square(120)),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 2.0,
                        ),
                      ]),
                ),
                Text(
                  'Sign in to continue your Crowd Wave experience',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey[300]),
                ),
                SizedBox.fromSize(
                  size: const Size.square(50),
                ),
                Container(
                  decoration: BoxDecoration(
                    //color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.transparent),
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
                          fillColor: Colors.white.withOpacity(0.2),
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
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 220,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle login
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const dasboard()), (route) => false);
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => const dasboard()));
                            print('Login button pressed...');
                          },
                          child: Text('Log In',style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text('OR', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 10),
            SizedBox(
              width: 220,
                child:ElevatedButton.icon(
                  onPressed: () {
                    // Handle Google login
                    print('Google login pressed...');
                  },
                  icon: const Icon(Icons.login_outlined, color: Colors.white),
                  label: const Text('Log in with Google',style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.white, width: 2),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),),
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
                                builder: (context) => const SignupWidget()));
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
          ),
        ),
      ),
    );
  }
}
