import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_ticket/Pages/User_/cards/eventDetailPage.dart';
import 'package:project_ticket/Pages/User_/cards/eventcard.dart';

import 'cards/eventCatalogCard.dart';
import 'cards/trendingEventCard.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {








  final Widget _spacer = const SizedBox(
    width: 10,
  );

  final Widget _hspacer = const SizedBox(
    height: 15,
  );

  Text _textHeading(data) {
    return Text(
      data,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    OutlinedButton(
                        onPressed: () {}, child: const Text("Trending Event")),
                    _spacer,
                    OutlinedButton(
                        onPressed: () {}, child: const Text("Upcoming Event")),
                    _spacer,
                    OutlinedButton(
                        onPressed: () {}, child: const Text("Past Event")),
                    _spacer,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: _textHeading("Trending Event")),
            ),
            SizedBox(
              height: 300,
              child: CarouselView(
                  itemExtent: 300,
                  shrinkExtent: 150,
                  padding: const EdgeInsets.all(10),
                  itemSnapping: true,
                  onTap: (value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const eventDetailPage(event: {},)));
                  },
                  children: [
                    testcard(),
                    testcard(),
                    testcard(),
                    // testcard(),
                    // testcard(),
                    // testcard(),
                    // testcard(),
                    // testcard(),
                    // testcard(),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: _textHeading("Event Catalog")),
            ),
            SizedBox(
              height: 60,
              child: ListView(
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    eventCatalog(
                        img:
                            "https://res.cloudinary.com/dnsjdvzdn/image/upload/v1731903309/cultural_msyzvv.jpg",
                        eventType: "Cultural"),
                    eventCatalog(
                        img:
                            "https://res.cloudinary.com/dnsjdvzdn/image/upload/v1731902337/workshops_klb4nv.jpg",
                        eventType: "Workshop"),
                    eventCatalog(
                        img:
                            "https://res.cloudinary.com/dnsjdvzdn/image/upload/v1731903235/download_ofu4qg.jpg",
                        eventType: "Guest Lecture"),
                    eventCatalog(
                        img:
                            "https://res.cloudinary.com/dnsjdvzdn/image/upload/v1731904088/download_1.jpg",
                        eventType: "Seminar"),
                    eventCatalog(
                        img:
                            "https://res.cloudinary.com/dnsjdvzdn/image/upload/v1731903876/hackathon.jpg",
                        eventType: "Hackathon"),
                    eventCatalog(
                        img:
                            "https://res.cloudinary.com/dnsjdvzdn/image/upload/v1731903876/images_1.jpg",
                        eventType: "Expo"),
                    eventCatalog(
                        img:
                            "https://res.cloudinary.com/dnsjdvzdn/image/upload/v1731905324/images_2.jpg",
                        eventType: "Conferences"),
                    eventCatalog(
                        img:
                            "https://res.cloudinary.com/dnsjdvzdn/image/upload/v1731903876/images.jpg",
                        eventType: "Tournament"),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: _textHeading("Explore")),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('eventDetails').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No events available.'));
                  }

                  final eventDocs = snapshot.data!.docs;

                  return Column(
                    children: eventDocs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;

                      return EventCard(
                        eventName: data['eventName'] ?? 'N/A',
                        eventDiscription: data['eventDiscription'] ?? 'N/A',
                        eventMode: data['eventMode'] ?? 'N/A',
                        eventVenue: data['eventVenue'] ?? 'N/A',
                        eventType: data['eventType'] ?? 'N/A',
                        eventWeblink: data['eventWeblink'] ?? '',
                        eventSocialLink: data['eventSocialLink'] ?? '',
                        eventSeats: data['eventSeats'] ?? 0,
                        eventDate: data['eventDate'] ?? 'N/A',
                        eventTime: data['eventTime'] ?? 'N/A',
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
