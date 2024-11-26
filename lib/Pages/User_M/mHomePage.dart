import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project_ticket/Pages/User_M/eventLisingPage.dart';
import 'package:project_ticket/Pages/User_M/dashboard/mDashboard.dart';
import 'package:project_ticket/Pages/miscellaneous/profilePage.dart';
import 'package:project_ticket/service/firebaseAuthService.dart';
import 'package:project_ticket/welcome_page.dart';

import 'mCustomDrawer.dart';

class mHomePage extends StatefulWidget {
  const mHomePage({super.key});

  @override
  State<mHomePage> createState() => _mHomePageState();
}

class _mHomePageState extends State<mHomePage> {
  int _selectedIndex = 0;
  final User? user = Auth().currentUser;

  final String? email = Auth().currentUser?.email;
  final String? username = Auth().currentUser?.displayName;

  final pages = [
    const EventManagerDashboard(),
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
        drawer: mCustomDrawer(),
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
                            Auth().signOut();
                            print("user logged in");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const welcome_page()));
                          },
                          child: const Text("Sign Out"),
                        )
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.account_circle))
          ],
          title: const Text("M_Dashboard"),
        ),
        body: pages[_selectedIndex],
        floatingActionButton: FloatingActionButton.extended(
            splashColor: Colors.greenAccent,
            label: const Text("Host Event"),
            icon: const Icon(Bootstrap.calendar2_event),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const eventListingPage()));
            }),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 5,
          selectedFontSize: 15,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
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
