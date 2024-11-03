import 'package:flutter/material.dart';
import 'package:project_ticket/Pages/User_/eventcard.dart';

class event extends StatelessWidget {
  const event({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(child:Column(
        children: [
          eventcard(),eventcard(),eventcard(),eventcard(),eventcard(),
        ],
      ),
    ),);
  }
}
