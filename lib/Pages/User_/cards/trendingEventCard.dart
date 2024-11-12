import 'package:flutter/material.dart';

class testcard extends StatelessWidget {
  const testcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 300,
          child: Image.asset(
            "assets/splashScreen.jpeg",
            fit: BoxFit.cover,
          ),
        ),
        const Positioned(
          left: 10,
          bottom: 25,
          child: Text(
            "Event",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),const Positioned(
          left: 10,
          bottom: 10,
          child: Text(
            "01-11-2024",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        )
      ],
    );
  }
}
