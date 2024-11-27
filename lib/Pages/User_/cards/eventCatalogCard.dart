import 'package:flutter/material.dart';
import 'package:project_ticket/Pages/User_/QuarriedEventCardPage.dart';

class eventCatalog extends StatelessWidget {
  const eventCatalog({super.key, required this.img, required this.eventType});
  final String img;
  final String eventType;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => QuarriedEventCardPage(category: eventType,)));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Card(
          elevation: 2,
          child: SizedBox(
            width: 200,
            height: 60,
            child: Stack(
              children: [
                Container(
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: NetworkImage(img), fit: BoxFit.cover)),
                ),
                Center(
                  child: Text(
                    eventType,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
