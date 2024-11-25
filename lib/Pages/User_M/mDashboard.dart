import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ticket/Pages/User_/cards/eventcard.dart'; // Import the eventCard

class mDashBoard extends StatefulWidget {
  const mDashBoard({super.key});

  @override
  State<mDashBoard> createState() => _mDashBoardState();
}

class _mDashBoardState extends State<mDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('eventDetails').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No events available.'));
            }

            final eventDocs = snapshot.data!.docs;

            // Build the list of event cards dynamically
            return Column(
              children: eventDocs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final eventId = doc.id;  // Get the eventId from Firestore

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
