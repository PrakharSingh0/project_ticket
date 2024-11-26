import 'package:flutter/material.dart';

class AttendeeValidationPage extends StatelessWidget {
  final String eventId;

  const AttendeeValidationPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Validate Attendees")),
      body: const Center(child: Text("Validation Page")),
    );
  }
}