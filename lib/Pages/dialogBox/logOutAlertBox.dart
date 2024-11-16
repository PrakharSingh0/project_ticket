import 'package:flutter/material.dart';

import '../../service/firebaseAuthService.dart';
import '../../welcome_page.dart';


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
          onPressed: () {
            // Add logout functionality here
            Auth().signOut();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const welcome_page()));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logged out successfully')),
            );
          },
          child: const Text('Logout'),
        ),
      ],
    ),
  );
}


void showLanguageDialog() {
  var context;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Select Language'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: Text('English')),
          ListTile(title: Text('Spanish')),
          ListTile(title: Text('French')),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}
