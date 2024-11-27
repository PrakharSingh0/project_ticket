import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ticket/Pages/User_/dashboard.dart';
import 'package:project_ticket/Pages/User_/customDrawer.dart';
import 'package:project_ticket/Pages/User_/myTicket.dart';
import 'package:project_ticket/service/firebaseAuthService.dart';

import '../miscellaneous/profilePage.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _selectedIndex = 0;
  String? userName=FirebaseAuth.instance.currentUser?.displayName;


  final String? email = Auth().currentUser?.email;
  final String? username = Auth().currentUser?.displayName;

  final pages = [
    const dashboard(),
    const MyTicket(),
    const profilePage(),
  ];

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: customDrawer(),
        appBar: AppBar(
          elevation: 5,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  // Optional: Show feedback to the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("You have been logged out.")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Logout failed: ${e.toString()}")),
                  );
                }
              },
            ),
          ],
          title: Text("Hi $username"),

        ),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 5,
          selectedFontSize: 15,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner), label: "My Ticket"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: "User Profile"),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            _onItemTapped(index);
          },
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
