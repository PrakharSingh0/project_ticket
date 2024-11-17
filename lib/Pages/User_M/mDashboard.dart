import 'package:flutter/material.dart';
import 'package:project_ticket/Pages/User_/cards/eventcard.dart';

class mDashBoard extends StatelessWidget {
  const mDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
      child: SingleChildScrollView(child:Column(
        children: [
          eventcard(),eventcard(),eventcard(),eventcard(),eventcard(),
        ],
      ),
      ),);
  }
}
