// import 'package:flutter/material.dart';
// import 'package:homez/web/orders_page.dart';
// import 'edit_services_page.dart';
// import 'services_page.dart';

// class AdminLayout extends StatefulWidget {
//   const AdminLayout({super.key});

//   @override
//   State<AdminLayout> createState() => _AdminLayoutState();
// }

// class _AdminLayoutState extends State<AdminLayout> {
//   int selectedIndex = 0;

//   final List<Widget> pages = [
//     const ServicesPage(),        // Upload Excel
//     const EditServicesPage(), 
//     const OrdersPage(),   // Edit Services
//   ];

//   final List<String> titles = [
//     "Upload Services",
//     "Edit Services",
//     "Orders",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(titles[selectedIndex]),
//         backgroundColor: const Color(0xFFF2F8FD),
//       ),

//       drawer: Drawer(
//      backgroundColor: Colors.white,
        
//         child: ListView(
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(color:  Color(0xFFF2F8FD)),
//               child: Text(
//                 "Admin Panel",
//                 style: TextStyle(color:  Color(0xFF093A61), fontSize: 20),
//               ),
//             ),

//             ListTile(
//               leading: const Icon(Icons.upload_file),
//               title: const Text("Upload Services",style: TextStyle(color: Color(0xFF093A61)),),
//               onTap: () {
//                 setState(() => selectedIndex = 0);
//                 Navigator.pop(context);
//               },
//             ),

//             ListTile(
//               leading: const Icon(Icons.edit),
//               title: const Text("Edit Services",style: TextStyle(color: Color(0xFF093A61)),),
//               onTap: () {
//                 setState(() => selectedIndex = 1);
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//   leading: const Icon(Icons.shopping_bag),
//   title: const Text("Orders",style: TextStyle(color: Color(0xFF093A61)),),
//   onTap: () {
//     setState(() => selectedIndex = 2);
//     Navigator.pop(context);
//   },
// ),
//           ],
//         ),
//       ),

//       body: pages[selectedIndex],
//     );
//   }
// }
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

  // القوائم والصفحات
  final List<Widget> pages = [
    const ServicesPage(),
    const EditServicesPage(),
    const OrdersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FD), // لون الخلفية الفاتح الموحد
      body: Row(
        children: [
          // 1. القائمة الجانبية (Sidebar)
          _buildSidebar(),

          // 2. المنطقة الرئيسية (Main Content)
          Expanded(
            child: Column(
              children: [
                // الشريط العلوي
                _buildHeader(),
                
                // منطقة عرض الصفحات (داخل حاوية بيضاء بظلال)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: pages[selectedIndex],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // مكوّن القائمة الجانبية
  Widget _buildSidebar() {
    return Container(
      width: 270,
      decoration: const BoxDecoration(
        color: Color(0xFF093A61), // الكحلي المعتمد
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Column(
        children: [
          const SizedBox(height: 50),
          // Logo Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB545),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.home_repair_service, color: Colors.white),
                ),
                const SizedBox(width: 15),
                const Text(
                  "HOMEZ ADMIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          
          // Navigation Items
          _buildNavItem(0, Icons.cloud_upload_outlined, "Upload Services"),
          _buildNavItem(1, Icons.edit_calendar_outlined, "Edit Services"),
          _buildNavItem(2, Icons.list_alt_rounded, "Orders Management"),
          
          const Spacer(),
          
          // Logout or Footer
          _buildNavItem(99, Icons.logout_rounded, "Logout"),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: ListTile(
        onTap: () {
          if (index == 99) {
            // منطق تسجيل الخروج هنا
          } else {
            setState(() => selectedIndex = index);
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFFFFB545) : Colors.white60,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white60,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  // مكوّن الشريط العلوي (Header)
  Widget _buildHeader() {
    String pageTitle = "";
    if (selectedIndex == 0) pageTitle = "Services Upload Center";
    if (selectedIndex == 1) pageTitle = "Service Customization";
    if (selectedIndex == 2) pageTitle = "Incoming Orders";

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            pageTitle,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF093A61),
            ),
          ),
          // Admin Profile Info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                const Text(
                  "Administrator",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: const Color(0xFFF2F8FD),
                  child: Icon(Icons.person, size: 18, color: const Color(0xFF093A61)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}