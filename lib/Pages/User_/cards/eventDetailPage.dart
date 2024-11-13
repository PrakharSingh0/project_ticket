import 'package:flutter/material.dart';

class eventDetailPage extends StatelessWidget {
  const eventDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton(),),
      body: ListView(
        children: [
          SizedBox(
            height: 300,
            child: Hero(tag: "event",
            child: Image.asset("assets/splashScreen.jpeg",fit: BoxFit.cover,)),
          ),
          Text("asdasd")
        ],
      ),
    );

  }
}
