import 'package:flutter/material.dart';

class myEvent extends StatelessWidget {
  const myEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: SizedBox(
            width: 200,
            height: 60,
            child: ElevatedButton(
                onPressed: () {}, child: const Text("QR Scanner")),
        ),
      ),
    );
  }
}
