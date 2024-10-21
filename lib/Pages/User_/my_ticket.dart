import 'package:flutter/material.dart';

class my_ticket extends StatefulWidget {
  const my_ticket({super.key});

  @override
  State<my_ticket> createState() => _my_ticketState();
}

class _my_ticketState extends State<my_ticket> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My Ticket"),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
        
        body: Text("sdasdadsadasdaf"),
      ),
    );
    ;
  }
}
