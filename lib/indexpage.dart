// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:homez/account.dart';
// import 'package:homez/home.dart';
// import 'package:homez/order_status.dart';
// import 'package:homez/request.dart';
// import 'package:homez/search.dart';


// class Indexpage extends StatefulWidget {
//   const Indexpage({
//     super.key,
//     required String firstName,
//     required String lastName,
//     String email='',
    
//   });
  

//   @override
//   State<Indexpage> createState() => _IndexpageState();
// }

// class _IndexpageState extends State<Indexpage> {
//   @override
// void initState() {
//   super.initState();
//   email = FirebaseAuth.instance.currentUser?.email;
// }
//   String?email ;
//   int _bottomNavbar = 0;
//   final List<Widget> _pages = [
//     Home(firstName: '', lastName: ''),
//     Search(),
//     Request(cartItems: [], email: email ?? ""),
//    // Account(name: "name", email: " "),
   
//     OrderStatus()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(index: _bottomNavbar, children: _pages),
//       bottomNavigationBar: ConvexAppBar(
//         style: TabStyle.react,
//         backgroundColor: Colors.white,
//         activeColor: const Color(0xFF093A61),
//         color: Colors.grey[600],
//         initialActiveIndex: _bottomNavbar,
//         onTap: (int index) {
//           setState(() {
//             _bottomNavbar = index;
//           });
//         },
//         items: [
//           TabItem(
//             icon: Container(
//               width: 44,
//               height: 44,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Color(0xFF093A61),
//               ),
//               alignment: Alignment.center,
//               child: Icon(Icons.home, color: Colors.white, size: 20),
//             ),
//             title: 'Home',
//           ),
//           TabItem(
//             icon: Container(
//               width: 44,
//               height: 44,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Color(0xFF093A61),
//               ),
//               alignment: Alignment.center,
//               child: Icon(Icons.search, color: Colors.white, size: 20),
//             ),
//             title: 'Search',
//           ),
//           TabItem(
//             icon: Container(
//               width: 44,
//               height: 44,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Color(0xFF093A61),
//               ),
//               alignment: Alignment.center,
//               child: Icon(Icons.request_page, color: Colors.white, size: 20),
//             ),
//             title: 'Request',
//           ),
//           TabItem(
//             icon: Container(
//               width: 44,
//               height: 44,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Color(0xFF093A61),
//               ),
//               alignment: Alignment.center,
//               child: Icon(Icons.account_box, color: Colors.white, size: 20),
//             ),
//             title: 'Account',
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:homez/account.dart';
import 'package:homez/home.dart';
import 'package:homez/order_status.dart';
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

  String email = '';

  @override
  void initState() {
    super.initState();

    email = FirebaseAuth.instance.currentUser?.email ?? '';
  }

  List<Widget> get _pages => [
    Home(firstName: '', lastName: '', email: email),
    Search(),
    Request(cartItems: [], email: email),
    OrderStatus(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomNavbar,
        children: _pages,
      ),

      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: Colors.white,
        activeColor: const Color(0xFF093A61),
        color: Colors.grey,
        initialActiveIndex: _bottomNavbar,
        onTap: (int index) {
          setState(() {
            _bottomNavbar = index;
          });
        },

        items: [
          TabItem(icon: Icon(Icons.home), title: 'Home'),
          TabItem(icon: Icon(Icons.search), title: 'Search'),
          TabItem(icon: Icon(Icons.request_page), title: 'Request'),
          TabItem(icon: Icon(Icons.account_box), title: 'Account'),
        ],
      ),
    );
  }
}
