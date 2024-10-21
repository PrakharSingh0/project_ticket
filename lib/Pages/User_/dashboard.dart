import 'package:flutter/material.dart';

class dasboard extends StatefulWidget {
  const dasboard({super.key});

  @override
  State<dasboard> createState() => _dasboardState();
}

class _dasboardState extends State<dasboard> {
  int _selectedIndex = 0;
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
      home: Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          elevation: 5,
          title: const Text("Dashboard"),
        ),
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
        body: const Text("this is dashboard ................"),
      ),
    );
    ;
  }
}
