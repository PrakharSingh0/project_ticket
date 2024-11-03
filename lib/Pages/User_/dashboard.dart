import 'package:flutter/material.dart';
import 'package:project_ticket/Pages/User_/Event.dart';
import 'package:project_ticket/Pages/User_/my_ticket.dart';
import 'package:project_ticket/Pages/User_/user_profile.dart';

class dasboard extends StatefulWidget {
  const dasboard({super.key});

  @override
  State<dasboard> createState() => _dasboardState();
}

class _dasboardState extends State<dasboard> {
  int _selectedIndex = 0;

  final pages = [
    const event(),
    const myticket(),
    const userProfile(),
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
        drawer: const Drawer(child: Column(children: [Text("User")],),),
        appBar: AppBar(
          elevation: 5,
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
