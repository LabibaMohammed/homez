import 'package:flutter/material.dart';
import 'package:homez/account.dart';
import 'package:homez/home.dart';
import 'package:homez/request.dart';
import 'package:homez/search.dart';

class Indexpage extends StatefulWidget {
  const Indexpage({super.key});

  @override
  State<Indexpage> createState() => _IndexpageState();
}

class _IndexpageState extends State<Indexpage> {
  int _bottomNavbar = 0;
  final List<Widget> _pages = [
    Home(),
    Search(),
    Request(),
    Account(name: "name", email: " ", imageUrl: "imageUrl"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _bottomNavbar, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavbar,
        onTap: (index) {
          setState(() {
            _bottomNavbar = index;
          });
        },
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: const Color(0xFF093A61),
        items: [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
          BottomNavigationBarItem(
            label: 'Request',
            icon: Icon(Icons.request_page),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(Icons.account_box),
          ),
        ],
      ),
    );
  }
}
