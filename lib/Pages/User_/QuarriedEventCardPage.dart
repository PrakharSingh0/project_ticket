import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cards/eventcard.dart';

class QuarriedEventCardPage extends StatefulWidget {
  const QuarriedEventCardPage({super.key, required this.category});
  final String category;

  @override
  State<QuarriedEventCardPage> createState() => _QuarriedEventCardPageState();
}

class _QuarriedEventCardPageState extends State<QuarriedEventCardPage> {
  late Stream<QuerySnapshot> _eventStream;

  Future<void> fetchData() async {
    _eventStream = FirebaseFirestore.instance
        .collection('eventDetails')
        .where("eventType", isEqualTo: widget.category)
        .snapshots();
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Call the method to fetch data when the page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _eventStream, // Stream that reloads when data is fetched
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
                final eventId = doc.id; // Capture the eventId from Firestore

                return EventCard(
                  eventId: eventId,  // Pass eventId to EventCard
                  eventName: data['eventName'] ?? 'N/A',
                  eventDiscription: data['eventDiscription'] ?? 'N/A',
                  eventMode: data['eventMode'] ?? 'N/A',
                  eventVenue: data['eventVenue'] ?? 'N/A',
                  eventType: data['eventType'] ?? 'N/A',
                  eventWebLink: data['eventWebLink'] ?? '',
                  eventSocialLink: data['eventSocialLink'] ?? '',
                  eventSeats: data['eventSeats'] ?? 0,
                  eventDate: data['eventDate'] ?? 'N/A',
                  eventTime: data['eventTime'] ?? 'N/A',
                  bannerImage: data['bannerImage'] ?? 'N/A',
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
