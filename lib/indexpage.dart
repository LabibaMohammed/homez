import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:homez/account.dart';
import 'package:homez/home.dart';
import 'package:homez/request.dart';
import 'package:homez/search.dart';

class Indexpage extends StatefulWidget {
  const Indexpage({
    super.key,
    required String firstName,
    required String lastName,
    required String email,
  });

  @override
  State<Indexpage> createState() => _IndexpageState();
}

class _IndexpageState extends State<Indexpage> {
  int _bottomNavbar = 0;
  final List<Widget> _pages = [
    Home(firstName: '', lastName: '', email: ''),
    Search(),
    Request(),
    Account(name: "name", email: " "),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _bottomNavbar, children: _pages),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: Colors.white,
        activeColor: const Color(0xFF093A61),
        color: Colors.grey[600],
        initialActiveIndex: _bottomNavbar,
        onTap: (int index) {
          setState(() {
            _bottomNavbar = index;
          });
        },
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.request_page, title: 'Request'),
          TabItem(icon: Icons.account_box, title: 'Account'),
        ],
      ),
    );
  }
}
