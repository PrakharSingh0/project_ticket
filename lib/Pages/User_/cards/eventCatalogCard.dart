import 'package:flutter/material.dart';

class eventCatalog extends StatelessWidget {
  const eventCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Card(
        elevation: 2,
        child: Stack(
          children: [
            Container(
              width: 200,
              height: 60,
              decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(image:AssetImage("assets/Hackathon.png"),fit: BoxFit.cover)
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Hackathon",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
