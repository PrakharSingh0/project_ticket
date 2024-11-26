import 'package:flutter/material.dart';

class AttendeesListPage extends StatelessWidget {
  final String eventId;
  final String eventName;

  const AttendeesListPage({super.key, required this.eventId, required this.eventName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attendees for $eventName")),
      body: const Center(child: Text("Attendees List")),
    );
  }
}