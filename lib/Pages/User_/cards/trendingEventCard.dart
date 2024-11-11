import 'package:flutter/material.dart';

class testcard extends StatelessWidget {
  const testcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 280,height: 250,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Colors.grey, width: 1.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(10),boxShadow: const [BoxShadow(color: Colors.black45,offset: Offset(5, 5),blurRadius: 5)]),
    child: Stack(
      children: [
        Image.asset("assets/splashScreen.jpeg",fit: BoxFit.cover,),
        const Text("Event")
      ],
    ));
  }
}
