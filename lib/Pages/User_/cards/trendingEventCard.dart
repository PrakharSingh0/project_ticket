import 'package:flutter/material.dart';
import 'dart:math';

class testcard extends StatelessWidget {
  testcard({super.key});

  final List<Map<String, String>> events = [
    {
      "title": "Tech Conference 2024",
      "date": "05-12-2024",
      "description":
          "A groundbreaking tech conference featuring industry leaders.",
      "image": "assets/Hackathon.png",
    },
    {
      "title": "Music Festival 2024",
      "date": "20-12-2024",
      "description": "An amazing music festival with top artists.",
      "image": "assets/Hackathon.png",
    },
    {
      "title": "Startup Expo 2024",
      "date": "12-01-2025",
      "description": "An expo showcasing the latest startups and innovations.",
      "image": "assets/Hackathon.png",
    },
  ];

  Map<String, String> getRandomEvent() {
    return events[Random().nextInt(events.length)];
  }

  @override
  Widget build(BuildContext context) {
    final event = getRandomEvent();

    return Padding(
      padding: const EdgeInsets.all(2),
      child: Stack(
        children: [
          // Container with event image as background
          Container(
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage(event["image"]!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Event title (positioned at the bottom left)
          Positioned(
            left: 10,
            bottom: 25,
            child: Text(
              event["title"]!,
              style:
                  const TextStyle(fontSize: 20, fontWeight:FontWeight.bold,color: Colors.white, shadows: [
                Shadow(
                  blurRadius: 5.0,
                  color: Colors.black,
                  offset: Offset(2.0, 2.0),
                ),
              ]),
            ),
          ),
          // Event date (positioned at the bottom left)
          Positioned(
            left: 10,
            bottom: 10,
            child: Text(
              event["date"]!,
              style:
                  const TextStyle(fontSize: 14, color: Colors.white, shadows: [
                Shadow(
                  blurRadius: 5.0,
                  color: Colors.black,
                  offset: Offset(2.0, 2.0),
                ),
              ]),
            ),
          ),
          // Button to navigate to event detail page
          // Positioned(
          //   right: 10,
          //   bottom: 10,
          //   child: SizedBox(width: 70,
          //     height: 30,
          //     child: ElevatedButton(
          //       onPressed: () {
          //         // Navigate to event detail page with animation
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => eventDetailPage(
          //               event: event,
          //             ),
          //           ),
          //         );
          //       },
          //       style: ElevatedButton.styleFrom(
          //         foregroundColor: Colors.orangeAccent, backgroundColor: Colors.white,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //       ),
          //       child: const Text("See More",style: TextStyle(fontSize: 10),),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
