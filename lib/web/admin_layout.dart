import 'package:flutter/material.dart';
import 'package:homez/web/orders_page.dart';
import 'edit_services_page.dart';
import 'services_page.dart';

class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const ServicesPage(),        // Upload Excel
    const EditServicesPage(), 
    const OrdersPage(),   // Edit Services
  ];

  final List<String> titles = [
    "Upload Services",
    "Edit Services",
    "Orders",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedIndex]),
        backgroundColor: const Color(0xFFF2F8FD),
      ),

      drawer: Drawer(
     backgroundColor: Colors.white,
        
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color:  Color(0xFFF2F8FD)),
              child: Text(
                "Admin Panel",
                style: TextStyle(color:  Color(0xFF093A61), fontSize: 20),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.upload_file),
              title: const Text("Upload Services",style: TextStyle(color: Color(0xFF093A61)),),
              onTap: () {
                setState(() => selectedIndex = 0);
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit Services",style: TextStyle(color: Color(0xFF093A61)),),
              onTap: () {
                setState(() => selectedIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
  leading: const Icon(Icons.shopping_bag),
  title: const Text("Orders",style: TextStyle(color: Color(0xFF093A61)),),
  onTap: () {
    setState(() => selectedIndex = 2);
    Navigator.pop(context);
  },
),
          ],
        ),
      ),

      body: pages[selectedIndex],
    );
  }
}