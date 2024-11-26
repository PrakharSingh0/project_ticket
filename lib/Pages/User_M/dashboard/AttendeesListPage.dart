import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendeesListPage extends StatelessWidget {
  final String eventId;

  const AttendeesListPage({super.key, required this.eventId});

  // Fetch attendees data by combining both collections and subcollections
  Future<List<Map<String, dynamic>>> _fetchAttendees() async {
    try {
      // Step 1: Query the 'registration' collection to get users for the specified eventId
      final registrationSnapshot = await FirebaseFirestore.instance
          .collection('registrations') // Query the 'registration' collection
          .where('eventId', isEqualTo: eventId) // Filter by the specific eventId
          .get();

      List<Map<String, dynamic>> attendeesList = [];

      // Step 2: For each user, fetch their details from the 'registrations' subcollection under the 'eventDetails'
      for (var registrationDoc in registrationSnapshot.docs) {
        final registrationData = registrationDoc.data();
        final userId = registrationData['userId'];

        // Fetch user details from the 'registrations' subcollection of the event
        final userSnapshot = await FirebaseFirestore.instance
            .collection('eventDetails') // The 'eventDetails' collection
            .doc(eventId) // The specific event document
            .collection('registrations') // The 'registrations' subcollection
            .doc(userId) // The document ID is the same as userId
            .get();

        if (userSnapshot.exists) {
          final userDetails = userSnapshot.data()!;

          // Combine the data
          attendeesList.add({
            'ticketId': registrationData['ticketId'] ?? 'N/A',
            'userEmail': userDetails['userEmail'] ?? 'No Email',
            'userName': userDetails['userName'] ?? 'No Name',
            'status': userDetails['status'] ?? 'Unknown',
            'timestamp': registrationData['timestamp']?.toDate().toString() ?? 'Unknown',
          });
        }
      }

      return attendeesList;
    } catch (e) {
      print("Error fetching attendees: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendee List')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchAttendees(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Error loading attendees"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No attendees registered."));
          }

          final attendees = snapshot.data!;

          return ListView.builder(
            itemCount: attendees.length,
            itemBuilder: (context, index) {
              final attendee = attendees[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(attendee['userName'] ?? 'No Name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email: ${attendee['userEmail']}"),
                      Text("Ticket ID: ${attendee['ticketId']}"),
                      Text("Status: ${attendee['status']}"),
                      Text("Registered on: ${attendee['timestamp']}"),
                    ],
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
