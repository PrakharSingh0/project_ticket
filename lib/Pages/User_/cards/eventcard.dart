import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'eventDetailPage.dart'; // Import the EventDetailsPage

class EventCard extends StatefulWidget {
  final String eventId; // Add eventId here
  final String eventName;
  final String eventDiscription;
  final String eventDate;
  final String eventTime;
  final String eventVenue;
  final String eventMode;
  final String eventType;
  final String eventWebLink;
  final String eventSocialLink;
  final int eventSeats;
  final String bannerImage;

  const EventCard({
    super.key,
    required this.eventId,  // Initialize eventId here
    required this.eventName,
    required this.eventDiscription,
    required this.eventMode,
    required this.eventVenue,
    required this.eventType,
    required this.eventWebLink,
    required this.eventSocialLink,
    required this.eventSeats,
    required this.eventDate,
    required this.eventTime,
    required this.bannerImage,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

Future<void> openUrl(String address) async {
  final Uri url = Uri.parse(address);
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.eventName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        widget.eventType,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      openUrl(widget.eventSocialLink);
                    },
                    iconSize: 30,
                    tooltip: "Social Media",
                    icon: const Icon(LineAwesome.instagram),
                  ),
                  IconButton(
                    onPressed: () async {
                      openUrl(widget.eventWebLink);
                    },
                    iconSize: 30,
                    tooltip: "Web Link",
                    icon: const Icon(Bootstrap.link_45deg),
                  ),
                ],
              ),
              const Divider(thickness: 1, color: Color(0xFF020202)),
              _buildInfoRow(context, 'Date : ', widget.eventDate),
              _buildInfoRow(context, 'Time : ', widget.eventTime),
              _buildInfoRow(context, 'Venue : ', widget.eventVenue),
              _buildInfoRow(context, 'Mode : ', widget.eventMode),
              Row(
                children: [
                  const Text(
                    "Seats Available : ",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${widget.eventSeats}',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to EventDetailPage and pass the event data including eventId
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => userEventDetailPage(
                            eventId: widget.eventId, // Pass eventId here
                            eventName: widget.eventName,
                            eventDescription: widget.eventDiscription,
                            eventMode: widget.eventMode,
                            eventVenue: widget.eventVenue,
                            eventType: widget.eventType,
                            eventWeblink: widget.eventWebLink,
                            eventSocialLink: widget.eventSocialLink,
                            eventSeats: widget.eventSeats,
                            eventDate: widget.eventDate,
                            eventTime: widget.eventTime,
                            bannerImage: widget.bannerImage,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                    ),
                    child: const Text(
                      'Enquire Now',
                      style: TextStyle(
                        fontFamily: 'Inter Tight',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String text, String data) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
        Text(
          data,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
