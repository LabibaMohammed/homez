import 'package:convex_bottom_bar/convex_bottom_bar.dart';
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
  int selectedIndex = 0;
  //int _bottomNavbar = 0;
  final List<Widget> _pages = [
    Home(),
    Search(),
    Request(),
    Account(name: "name", email: " ", imageUrl: "imageUrl"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],

      bottomNavigationBar: ConvexAppBar(
        height: 50,
        backgroundColor: const Color(0xFF093A61), 
        color: Colors.white,
        activeColor: Colors.white,
        style: TabStyle.react, 
        curveSize: 70,
        
        items: const [
          TabItem(icon: Icons.home, title: 'Home',),
          TabItem(icon: Icons.search, title: 'search'),
          TabItem(icon:Icons.request_page, title: 'request'),
         // TabItem(icon: Icons.bar_chart, title: 'Progress'),
         // TabItem(icon: Icons.person, title: 'Profile'),
        ],
      
        initialActiveIndex: 2,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
    //  Scaffold(
    //   body: IndexedStack(index: _bottomNavbar, children: _pages),
    //   bottomNavigationBar: BottomNavigationBar(
    //     currentIndex: _bottomNavbar,
    //     onTap: (index) {
    //       setState(() {
    //         _bottomNavbar = index;
    //       });
    //     },
    //     unselectedItemColor: Colors.grey[600],
    //     selectedItemColor: const Color(0xFF093A61),
    //     items: [
    //       BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
    //       BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
    //       BottomNavigationBarItem(
    //         label: 'Request',
    //         icon: Icon(Icons.request_page),
    //       ),
    //       BottomNavigationBarItem(
    //         label: 'Account',
    //         icon: Icon(Icons.account_box),
    //       ),
    //     ],
    //   ),
    // );
  }
}
