import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  FAQPage({super.key});

  final List<Map<String, String>> faqs = [
    {
      'question': 'How can I create a new ticket?',
      'answer':
      'Navigate to the "Create Ticket" section from the main menu. Fill in the required details and click "Submit".'
    },
    {
      'question': 'How can I view my booked tickets?',
      'answer':
      'Go to the "My Tickets" tab in the navigation menu to view all your tickets and their statuses.'
    },
    {
      'question': 'Can I cancel a ticket after booking?',
      'answer':
      'Yes, you can cancel a ticket in the "My Tickets" section by selecting it and clicking "Cancel Ticket".'
    },
    {
      'question': 'What should I do if I encounter an error while booking?',
      'answer':
      'Try restarting the app and booking again. If the issue persists, contact CrowdWave support at support@crowdwave.com.'
    },
    {
      'question': 'Is there a way to track the status of my tickets?',
      'answer':
      'You can track ticket status in the "My Tickets" section, showing statuses like "Open", "In Progress", etc.'
    },
    {
      'question': 'Are there any fees for changing my ticket booking?',
      'answer':
      'Changing a booking may incur additional fees based on the terms and conditions of the ticket type. Please check the ticket details or contact CrowdWave support for more information.'
    },
    {
      'question': 'What payment methods are supported?',
      'answer':
      'CrowdWave supports various payment methods, including credit/debit cards, digital wallets, and net banking. Please refer to the checkout page for the complete list of available options.'
    },
    {
      'question': 'How do I reset my password?',
      'answer':
      'To reset your password, go to the login page and click "Forgot Password?". Follow the instructions provided to reset your password.'
    },
    {
      'question': 'What should I do if I do not receive a booking confirmation email?',
      'answer':
      'Check your spam/junk folder. If you still haven’t received the confirmation, contact CrowdWave support at support@crowdwave.com.'
    },
    {
      'question': 'Can I book tickets for multiple users in one transaction?',
      'answer':
      'Yes, you can book tickets for multiple users by selecting the desired number of tickets and providing details for each participant.'
    },
    {
      'question': 'Is my data secure with the CrowdWave app?',
      'answer':
      'Yes, your data is secure. We use advanced security protocols and encryption to protect your information.'
    },
    {
      'question': 'How do I provide feedback or report a bug?',
      'answer':
      'We welcome your feedback! Go to the "Help & Support" section and select "Contact Support" to report a bug or provide feedback.'
    },
    {
      'question': 'How can I update my personal information?',
      'answer':
      'To update your personal information, go to the "Profile" section in the app settings and make the necessary changes.'
    },
    {
      'question': 'Can I use the app on multiple devices?',
      'answer':
      'Yes, you can use the CrowdWave app on multiple devices by signing in with the same account credentials.'
    },
    {
      'question': 'Why am I not able to log in?',
      'answer':
      'If you’re unable to log in, please check your internet connection, ensure your login details are correct, or try resetting your password.'
    },
    {
      'question': 'What is the refund policy?',
      'answer':
      'Refunds are subject to the terms and conditions of the ticket type you purchased. Please refer to the ticket details or contact CrowdWave support for more information.'
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4,
                child: ExpansionTile(
                  title: Text(
                    faqs[index]['question']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_down, size: 24),
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  childrenPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.topLeft,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        faqs[index]['answer']!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
