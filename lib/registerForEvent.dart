import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

Future<String> registerForEvent(String eventId) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("User is not logged in");
    }

    // Generate a unique ticket ID
    String ticketId = const Uuid().v4();

    // Reference to the event's registrations subcollection
    DocumentReference registrationRef = FirebaseFirestore.instance
        .collection('eventDetails')
        .doc(eventId)
        .collection('registrations')
        .doc(user.uid);

    // Save the registration details
    await registrationRef.set({
      'userName': user.displayName ?? "Anonymous",
      'userEmail': user.email ?? "",
      'ticketID': ticketId,
      'status': 'valid',
    });

    print("Registration successful. Ticket ID: $ticketId");
    return ticketId; // Return the ticket ID
  } catch (e) {
    print("Error during registration: $e");
    rethrow;
  }
}
