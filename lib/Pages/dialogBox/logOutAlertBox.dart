import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



void showLogoutConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirm Logout'),
      content: const Text('Are you sure you want to log out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            // Perform logout
            try {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Logged out successfully")),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Logout failed: ${e.toString()}")),
              );
            }
          },
          child: const Text('Logout'),
        ),
      ],
    ),
  );
}



