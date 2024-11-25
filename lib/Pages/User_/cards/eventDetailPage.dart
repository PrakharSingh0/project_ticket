import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../registerForEvent.dart';
import 'RegistrationConfirmationScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventDetailPage extends StatefulWidget {
  final String eventId; // Add eventId to uniquely identify the event
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

  const EventDetailPage({
    super.key,
    required this.eventId, // Ensure eventId is passed to this page
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

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  bool isAlreadyRegistered = false; // Variable to track registration status

  @override
  void initState() {
    super.initState();
    checkIfUserIsRegistered();
  }

  // Check if the current user is already registered for the event
  Future<void> checkIfUserIsRegistered() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return;
    }

    try {
      // Check if the user is already registered for this event
      final registrationQuery = await FirebaseFirestore.instance
          .collection('registrations')  // Ensure correct collection
          .where('eventId', isEqualTo: widget.eventId)
          .where('userId', isEqualTo: currentUser.uid) // Check if the user is already registered
          .get();

      setState(() {
        isAlreadyRegistered = registrationQuery.docs.isNotEmpty; // Update the status
      });
    } catch (e) {
      print("Error checking registration status: $e");
    }
  }

  Widget hSpacer(double size) {
    return SizedBox(height: size);
  }

  Future<void> openUrl(String address) async {
    final Uri url = Uri.parse(address);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _registerForEvent(BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      // If the user is not authenticated
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please log in to register for an event.")),
      );
      return;
    }

    try {
      // Proceed with registration if not already registered
      String ticketId = await registerForEvent(widget.eventId);

      // Store the registration in Firestore to mark the user as registered
      await FirebaseFirestore.instance.collection('registrations').add({
        'eventId': widget.eventId,
        'userId': currentUser.uid,
        'ticketId': ticketId,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Navigate to the Registration Confirmation Screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegistrationConfirmationScreen(
            eventId: widget.eventId,
            ticketId: ticketId,
          ),
        ),
      );
    } catch (e) {
      // Show an error message if registration fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed: $e")),
      );
    }
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
                image: NetworkImage(widget.bannerImage),
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
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 550),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            // Event Name
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.eventName,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => openUrl(widget.eventWeblink),
                                      icon: const Icon(
                                        Bootstrap.link_45deg,
                                        size: 30,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => openUrl(widget.eventSocialLink),
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
                            Text(
                              widget.eventType,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.orangeAccent,
                              ),
                            ),
                            hSpacer(20),
                            _buildDetailRow("Date", widget.eventDate),
                            _buildDetailRow("Time", widget.eventTime),
                            _buildDetailRow("Venue", widget.eventVenue),
                            _buildDetailRow("Mode", widget.eventMode),
                            _buildDetailRow("Available Seats", '${widget.eventSeats}'),
                            hSpacer(20),
                            Text(
                              widget.eventDescription,
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
                onPressed: isAlreadyRegistered ? null : () => _registerForEvent(context),  // Disable the button if already registered
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  isAlreadyRegistered ? "Already Registered" : "Register Now",  // Change text if already registered
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
