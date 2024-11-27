import 'package:flutter/material.dart';

import '../dialogBox/logOutAlertBox.dart';
import 'helpAndSupport.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});


  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  void _toggleDarkMode() {
    setState(() {
      _darkModeEnabled = !_darkModeEnabled;
    });
    // Additional functionality for changing the theme can be added here.
    // E.g., integrating a ThemeProvider to manage the app's theme state.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        children: [
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
              // Additional code for handling notification state can go here.
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            value: _darkModeEnabled,
            onChanged: (value) => _toggleDarkMode(),
          ),
          //

          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & Support'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HelpSupportPage())
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => showLogoutConfirmation(context),
          ),
        ],
      ),
    );
  }
}

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact Info",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "For support, you can reach us at Crowdwaves.com\nor call us at Nowhere.",
            ),
          ],
        ),
      ),
    );
  }
}
