import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class EventDetailPage extends StatelessWidget {
  final String eventName;
  final String eventDescription;
  final String eventMode;
  final String eventVenue;
  final String eventType;
  final String eventWeblink;
  final String eventSocialLink;
  final int eventSeats;
  final String eventDate;
  final String eventTime;
  final String bannerImage;
  final Map<String, String> event;

  const EventDetailPage({
    super.key,
    required this.event,
    required this.eventName,
    required this.eventDescription,
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

  Widget hSpacer(double size) {
    return SizedBox(height: size);
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: const BackButton(),
      ),
      body: Stack(
        children: [
          // Banner Image
          Container(
            height: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(bannerImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 3),
              Flexible(
                flex: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          // Event Name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensures space between text and icons
                            children: [
                              // Event Name
                              Expanded(
                                child: Text(
                                  eventName,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              // Icons
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // Handle link button action
                                    },
                                    icon: const Icon(
                                      Bootstrap.link_45deg,
                                      size: 30,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // Handle global button action
                                    },
                                    icon: const Icon(
                                      LineAwesome.instagram,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          hSpacer(0),
                          // Event Type
                          Text(
                            eventType,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.orangeAccent,
                            ),
                          ),
                          hSpacer(20),
                          // Event Details
                          _buildDetailRow("Date", eventDate),
                          _buildDetailRow("Time", eventTime),
                          _buildDetailRow("Venue", eventVenue),
                          _buildDetailRow("Mode", eventMode),
                          _buildDetailRow("Available Seats", '$eventSeats' ),
                          hSpacer(20),
                          // Event Description
                          Text(
                            eventDescription,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Floating Apply Button
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: FractionallySizedBox(
              widthFactor: 0.6,
              child: ElevatedButton(
                onPressed: () {
                  // Handle apply action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Apply Now",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
