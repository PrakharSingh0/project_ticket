import 'package:flutter/material.dart';

class RegistrationConfirmationScreen extends StatelessWidget {
  final String eventId;
  final String ticketId;

  RegistrationConfirmationScreen({
    required this.eventId,
    required this.ticketId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration Successful"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "You have successfully registered for the event!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              "Your Ticket ID:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              ticketId,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Return to the event list
              },
              child: const Text("Back to Events"),
            ),
          ],
        ),
      ),
    );
  }
}
