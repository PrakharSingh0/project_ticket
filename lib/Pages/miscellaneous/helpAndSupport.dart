import 'package:flutter/material.dart';

class helpAndSupport extends StatelessWidget {
  const helpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(onPressed: () {
        Navigator.pop(context);
      }),title: const Text("Supports"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Contact Info"),
          ],
        ),
      ),
    );
  }
}
