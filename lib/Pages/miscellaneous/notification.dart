import 'package:flutter/material.dart';

class notification extends StatelessWidget {
   notification({super.key});

  final List<Map<String, String>> notifications = [
    {
      'title': 'New Ticket Confirmation',
      'description':
      'Your ticket for the "Annual Tech Summit" has been confirmed. Check "My Tickets" for details.',
      'date': 'Nov 8, 2024'
    },
    {
      'title': 'System Maintenance Notice',
      'description':
      'The CrowdWave app will undergo maintenance on Nov 12 from 1 AM to 4 AM UTC. Please plan accordingly.',
      'date': 'Nov 7, 2024'
    },
    {
      'title': 'Special Discount',
      'description':
      'Enjoy a 20% discount on all ticket bookings this week. Limited offer!',
      'date': 'Nov 5, 2024'
    },
    {
      'title': 'Profile Update',
      'description':
      'Your profile information was successfully updated. Thank you for keeping your details current.',
      'date': 'Nov 4, 2024'
    },
    {
      'title': 'CrowdWave News',
      'description':
      'We are thrilled to announce our new feature release for ticket tracking. Update the app to enjoy the latest features!',
      'date': 'Nov 1, 2024'
    },
    {
      'title': 'CrowdWave News',
      'description':
      'We are thrilled to announce our new feature release for ticket tracking. Update the app to enjoy the latest features!',
      'date': 'Nov 1, 2024'
    },
    {
      'title': 'CrowdWave News',
      'description':
      'We are thrilled to announce our new feature release for ticket tracking. Update the app to enjoy the latest features!',
      'date': 'Nov 1, 2024'
    },{
      'title': 'CrowdWave News',
      'description':
      'We are thrilled to announce our new feature release for ticket tracking. Update the app to enjoy the latest features!',
      'date': 'Nov 1, 2024'
    },{
      'title': 'CrowdWave News',
      'description':
      'We are thrilled to announce our new feature release for ticket tracking. Update the app to enjoy the latest features!',
      'date': 'Nov 1, 2024'
    },{
      'title': 'CrowdWave News',
      'description':
      'We are thrilled to announce our new feature release for ticket tracking. Update the app to enjoy the latest features!',
      'date': 'Nov 1, 2024'
    },



  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12.0),
                  leading: const Icon(
                    Icons.notifications_active,
                    size: 36,
                    color: Colors.blue,
                  ),
                  title: Text(
                    notifications[index]['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4.0),
                      Text(
                        notifications[index]['description']!,
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        notifications[index]['date']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      // backgroundColor: Colors.grey[100],
    );
  }
}
