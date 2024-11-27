import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  final String eventName;
  final String eventDiscription;
  final String eventMode;
  final String eventVenue;
  final String eventType;
  final String eventWeblink;
  final String eventSocialLink;
  final int eventSeats;
  final String eventDate;
  final String eventTime;
  final String bannerImage;

  // Constructor to receive the event details
  const EventDetailsPage({
    super.key,
    required this.eventName,
    required this.eventDiscription,
    required this.eventMode,
    required this.eventVenue,
    required this.eventType,
    required this.eventWeblink,
    required this.eventSocialLink,
    required this.eventSeats,
    required this.eventDate,
    required this.eventTime,
    required this.bannerImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Type: $eventType',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Date: $eventDate', style: const TextStyle(fontSize: 16)),
            Text('Time: $eventTime', style: const TextStyle(fontSize: 16)),
            Text('Venue: $eventVenue', style: const TextStyle(fontSize: 16)),
            Text('Mode: $eventMode', style: const TextStyle(fontSize: 16)),
            Text('Seats Available: $eventSeats', style: const TextStyle(fontSize: 16)),
            Text('Description: $eventDiscription', style: const TextStyle(fontSize: 16)),
            SizedBox(
              width: 300,
              height: 300,
                child: Image.network(bannerImage)),
            // Optionally, add buttons for social links and website
            // Example:
            // Text('Website: $eventWeblink'),
          ],
        ),
      ),
    );
  }
}
