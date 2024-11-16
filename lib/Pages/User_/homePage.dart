import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ticket/Pages/User_/dashboard.dart';
import 'package:project_ticket/Pages/User_/customDrawer.dart';
import 'package:project_ticket/Pages/User_/myTicket.dart';
import 'package:project_ticket/service/firebaseAuthService.dart';

import '../dialogBox/logOutAlertBox.dart';
import '../miscellaneous/profilePage.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _selectedIndex = 0;
  final User? user = Auth().currentUser;


  final String? email = Auth().currentUser?.email;
  final String? username = Auth().currentUser?.displayName;

  final pages = [
    const dashboard(),
    const myTicket(),
    const profilePage(),
  ];

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }


  // void _showLogoutConfirmation(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Confirm Logout'),
  //       content: const Text('Are you sure you want to log out?'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             // Add logout functionality here
  //             Auth().signOut();
  //             Navigator.pushReplacement(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) =>
  //                     const welcome_page()));
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(content: Text('Logged out successfully')),
  //             );
  //           },
  //           child: const Text('Logout'),
  //         ),
  //       ],
  //     ),
  //   );
  // }


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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Account"),
                      content: Text(
                        "User Name : $username \n"
                        "User Email : $email ",
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            showLogoutConfirmation(context);
                                                    },
                          child: const Text("Sign Out"),
                        )
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.account_circle))
          ],
          title: const Text("Dashboard"),
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
