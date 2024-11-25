import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyTicket extends StatefulWidget {
  const MyTicket({super.key});

  @override
  _MyTicketState createState() => _MyTicketState();
}

class _MyTicketState extends State<MyTicket> {
  // This will store the list of events the user has registered for
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
      // If user is not logged in, return an empty list
      return [];
    }

    try {
      // Query Firestore to get the registrations for the current user
      final registrationQuery = await FirebaseFirestore.instance
          .collection('registrations')
          .where('userId', isEqualTo: currentUser.uid)
          .get();

      // Prepare a list of events and their ticket IDs
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
    return FutureBuilder<List<Map<String, dynamic>>>(
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

        // If we have data, display the list of events
        final tickets = snapshot.data!;
        return ListView.builder(
          itemCount: tickets.length,
          itemBuilder: (context, index) {
            final ticket = tickets[index];
            return Card(
              margin: const EdgeInsets.all(8),
              elevation: 5,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(ticket['eventName']),
                subtitle: Text('Ticket ID: ${ticket['ticketId']}'),
              ),
            );
          },
        );
      },
    );
  }
}
