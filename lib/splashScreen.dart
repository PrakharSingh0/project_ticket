import 'package:flutter/material.dart';

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(

        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.greenAccent, Colors.lightBlue],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),

          child: const Center(
            child: Text(
              "Crowd Wave",
              style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold,fontSize: 64),
            ),
          ),
        ),
      ),
    );
  }
}