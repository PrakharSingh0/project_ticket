import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RegistrationConfirmationScreen extends StatelessWidget {
  final String eventId;
  final String ticketId;

  const RegistrationConfirmationScreen({
    required this.eventId,
    required this.ticketId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration Successful"),
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            const Text(
              "Congratulations!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              "You have successfully registered for the event.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // QR Code Section
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    QrImageView(
                      data: ticketId, // Ticket ID for the QR code
                      size: 180,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Scan to View Ticket",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Ticket ID
            const Text(
              "Your Ticket ID:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              ticketId,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 40),

            // Button to navigate back to events
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Return to the event list
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Back to Events",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
