import 'package:flutter/material.dart';

class testcard extends StatelessWidget {
  const testcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(image:AssetImage("assets/splashScreen.jpeg"),fit: BoxFit.fill)
            ),
          ),
          const Positioned(
            left: 10,
            bottom: 25,
            child: Text(
              "Event",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          const Positioned(
            left: 10,
            bottom: 10,
            child: Text(
              "01-11-2024",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
