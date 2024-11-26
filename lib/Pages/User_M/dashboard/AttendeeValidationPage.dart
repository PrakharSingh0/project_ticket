import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanPage extends StatefulWidget {
  final String eventId;

  const QRScanPage({Key? key, required this.eventId}) : super(key: key);

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  bool isProcessing = false;
  final Set<String> validatedTickets = {}; // Tracks already validated tickets

  Future<void> validateTicket(String ticketId) async {
    setState(() {
      isProcessing = true;
    });

    try {
      // Fetch the attendee from the `registrations` subcollection
      final eventDoc = FirebaseFirestore.instance
          .collection('eventDetails')
          .doc(widget.eventId);

      final registrationQuery = await eventDoc
          .collection('registrations')
          .where('ticketID', isEqualTo: ticketId)
          .get();

      if (registrationQuery.docs.isNotEmpty) {
        final doc = registrationQuery.docs.first;
        final attendeeData = doc.data();

        if (attendeeData['status'] == 'valid') {
          // Update the status to "Joined the Event"
          await doc.reference.update({'status': 'Joined the Event'});

          _showFeedbackDialog(
            title: "Success",
            message: "Ticket $ticketId is validated!",
            isSuccess: true,
          );
        } else {
          _showFeedbackDialog(
            title: "Already Validated",
            message: "This ticket was already validated.",
            isSuccess: false,
          );
        }
      } else {
        _showFeedbackDialog(
          title: "Failure",
          message: "Invalid Ticket ID: $ticketId",
          isSuccess: false,
        );
      }
    } catch (e) {
      _showFeedbackDialog(
        title: "Error",
        message: "An error occurred while validating the ticket.",
        isSuccess: false,
      );
    }

    setState(() {
      isProcessing = false;
    });
  }

  void _showFeedbackDialog({
    required String title,
    required String message,
    required bool isSuccess,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: isSuccess ? Colors.green : Colors.red),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              if (isProcessing) return; // Skip if already processing

              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                final String? ticketId = barcode.rawValue;
                if (ticketId != null && !validatedTickets.contains(ticketId)) {
                  validatedTickets.add(ticketId); // Mark ticket as processed
                  validateTicket(ticketId); // Process the ticket
                  break; // Stop processing after the first valid barcode
                }
              }
            },
          ),
          if (isProcessing)
            Container(
              color: Colors.black45,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
