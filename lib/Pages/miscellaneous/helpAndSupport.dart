import 'package:flutter/material.dart';

import 'faqsPage.dart';

class helpAndSupport extends StatelessWidget {
  const helpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(onPressed: () {
        Navigator.pop(context);
      }),title: const Text("Supports"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Contact Info"),
          ],
        ),
      ),
    );
  }
}





class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.chat_bubble_outline),
            title: const Text('Contact Support'),
            onTap: () {
              showContactSupportDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text('FAQs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FAQPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('App Information'),
            onTap: () {
              showAppInformationDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void showContactSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Contact Support'),
          content: const Text(
              'For support, you can reach us at support@example.com or call 123-456-7890.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showAppInformationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('App Information'),
          content: const Text(
              'Ticketing Management and Booking App v1.0\n\nDeveloped by CrowdWaves Team.\n© 2024 CrowdWaves. All rights reserved.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

