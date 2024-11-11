import 'package:flutter/material.dart';

class eventDetailPage extends StatelessWidget {
  const eventDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Container(
        child: Hero(tag: "event",
        child: Image.asset("assets/splashScreen.jpeg")),
      )],
    );

  }
}
