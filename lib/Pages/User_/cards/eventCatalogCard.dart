import 'package:flutter/material.dart';

class eventCatalog extends StatelessWidget {
  const eventCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 200,height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors.grey, width: 1.0, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10),boxShadow: const [BoxShadow(color: Colors.black45,offset: Offset(5, 5),blurRadius: 5)]),
        child: const Column(
          children: [
            Text("Widget Here"),
          ],
        ));
  }
}
