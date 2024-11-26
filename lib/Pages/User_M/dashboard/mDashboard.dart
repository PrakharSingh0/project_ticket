import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icons_plus/icons_plus.dart';

import 'AttendeeValidationPage.dart';
import 'AttendeesListPage.dart';
import 'ManagerEventDetailPage.dart'; // Your event details page
import 'EditEventPage.dart'; // Page to edit the event details

class EventManagerDashboard extends StatelessWidget {
  const EventManagerDashboard({super.key});

  Future<List<Map<String, dynamic>>> _fetchManagerEvents() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return [];
    }

    try {
      final eventsQuery = await FirebaseFirestore.instance
          .collection('eventDetails')
          .where('managerId', isEqualTo: currentUser.uid)
          .get();

      return eventsQuery.docs.map((doc) {
        final data = doc.data();
        data['eventId'] = doc.id; // Include document ID as eventId
        return data;
      }).toList();
    } catch (e) {
      print("Error fetching events: $e");
      return [];
    }
  }

  void _showEventOptionsDialog(BuildContext context, Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 16,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Event title
              const Text(
                'Manage Event:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                '${event['eventName'] ?? 'Event'}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // List of options
              _buildDialogOption(
                context,
                icon: Icons.edit,
                color: Colors.blue,
                title: "Edit Event",
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditEventPage(event: event, eventId: event['eventId'],),
                    ),
                  );
                },
              ),
              _buildDialogOption(
                context,
                icon: Icons.visibility,
                color: Colors.green,
                title: "Preview Your Listing",
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MangerEventDetailPage(event: event),
                    ),
                  );
                },
              ),
              _buildDialogOption(
                context,
                icon: Bootstrap.list,
                color: Colors.orangeAccent,
                title: "Attendees List",
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendeesListPage(eventId: event['eventId'],),
                    ),
                  );
                },
              ),
              _buildDialogOption(
                context,
                icon: Icons.check,
                color: Colors.purple,
                title: "Validate Attendees",
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRScanPage(eventId: event['eventId']),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Cancel button with modern style
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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

  Widget _buildDialogOption(BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Manager Dashboard'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchManagerEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error loading events"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hosted events found."));
          }

          final events = snapshot.data!;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    _showEventOptionsDialog(context, event);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['eventName'] ?? 'Event Name Not Available',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text("📅 Date: ${event['eventDate'] ?? 'Not Available'}"),
                        Text("⏰ Time: ${event['eventTime'] ?? 'Not Available'}"),
                        Text("📍 Venue: ${event['eventVenue'] ?? 'Not Specified'}"),
                        Text("💺 Seats Left: ${event['eventSeats'] ?? 0}"),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
