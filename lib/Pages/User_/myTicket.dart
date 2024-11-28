import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyTicket extends StatefulWidget {
  const MyTicket({super.key});

  @override
  _MyTicketState createState() => _MyTicketState();
}

class _MyTicketState extends State<MyTicket> {
  late Future<List<Map<String, dynamic>>> _userTickets;

  @override
  void initState() {
    super.initState();
    _userTickets = _fetchUserTickets();
  }

  // Fetch the events that the user is registered for
  Future<List<Map<String, dynamic>>> _fetchUserTickets() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return [];
    }

    try {
      // Query Firestore to get the registrations for the current user
      final registrationQuery = await FirebaseFirestore.instance
          .collection('registrations')
          .where('userId', isEqualTo: currentUser.uid)
          .get();

      List<Map<String, dynamic>> tickets = [];

      for (var doc in registrationQuery.docs) {
        final eventId = doc['eventId'];
        final ticketId = doc['ticketId'];

        // Fetch the event details
        final eventDoc = await FirebaseFirestore.instance
            .collection('eventDetails')
            .doc(eventId)
            .get();

        if (eventDoc.exists) {
          tickets.add({
            'eventName': eventDoc['eventName'],
            'ticketId': ticketId,
            'eventId': eventId,
            'eventDate': eventDoc['eventDate'],
            'eventTime': eventDoc['eventTime'],
            'eventVenue': eventDoc['eventVenue'],
          });
        }
      }

      return tickets;
    } catch (e) {
      print("Error fetching user tickets: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(  // Build the list after fetching tickets
      future: _userTickets,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Error loading tickets"));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No events found"));
        }

        final tickets = snapshot.data!;

        return ListView.builder(
          itemCount: tickets.length,
          itemBuilder: (context, index) {
            final ticket = tickets[index];
            final ticketId = ticket['ticketId'];
            final eventName = ticket['eventName'];
            final eventDate = ticket['eventDate'];
            final eventTime = ticket['eventTime'];
            final eventVenue = ticket['eventVenue'];

            return Card(
              margin: const EdgeInsets.all(8),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  eventName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      'Date: $eventDate',
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    Text(
                      'Time: $eventTime',
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    Text(
                      'Venue: $eventVenue',
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.qr_code, size: 30, color: Colors.blue),
                  onPressed: () => _showTicketQRCodeDialog(ticket),
                ),

              ),
            );
          },
        );
      },
    );
  }

  // Method to show QR Code in a dialog

  void _showTicketQRCodeDialog(Map<String, dynamic> ticket) {
    final ticketId = ticket['ticketId'];
    final eventName = ticket['eventName'];
    final eventDate = ticket['eventDate'];
    final eventTime = ticket['eventTime'];
    final eventVenue = ticket['eventVenue'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Rounded corners for modern look
          ),
          elevation: 12, // Subtle shadow for depth
          child: Padding(
            padding: const EdgeInsets.all(20), // Padding for consistent spacing
            child: Column(
              mainAxisSize: MainAxisSize.min, // Adjust height dynamically
              crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch to match parent width
              children: [
                // Event Details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal, // Modern accent color
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 5),
                        Text(
                          "Date: $eventDate",
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 5),
                        Text(
                          "Time: $eventTime",
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 5),
                        Text(
                          "Venue: $eventVenue",
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // QR Code
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100], // Light background for QR code
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: QrImageView(
                      data: ticketId, // Data encoded in the QR code
                      version: QrVersions.auto,
                      size: 200.0,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Ticket ID
                Text(
                  "Ticket ID: $ticketId",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                // Instructions
                const Text(
                  "This QR code is your unique ticket for the event. Please present it at the entry point.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                // Close Button
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Accent color for the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      "Close",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}

