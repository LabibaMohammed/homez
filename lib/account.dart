// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'theme_provider.dart';
// import 'login.dart'; // عدلي المسار حسب مشروعك

// class Account extends StatefulWidget {
//   final String name;
//   final String email;

//   const Account({Key? key, required this.name, required this.email})
//     : super(key: key);

//   @override
//   State<Account> createState() => _AccountState();
// }

// class _AccountState extends State<Account> {
//   late String name;
//   late String email;
//   String phone = "000-000-0000"; // قيمة افتراضية
//   String imagePath = "images1/avatar1.png";

//   @override
//   void initState() {
//     super.initState();
//     name = widget.name;
//     email = widget.email;
//   }

//   // دالة تعديل الملف الشخصي
//   void editProfile() {
//     TextEditingController nameController = TextEditingController(text: name);
//     TextEditingController phoneController = TextEditingController(text: phone);

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Edit Profile"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(labelText: "Name"),
//             ),
//             TextField(
//               controller: phoneController,
//               decoration: const InputDecoration(labelText: "Phone"),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 name = nameController.text;
//                 phone = phoneController.text;
//               });
//               Navigator.pop(context);
//               @override
//               Widget build(BuildContext context) {
//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 40),
//                       CircleAvatar(
//                         radius: 60,
//                         backgroundImage: AssetImage(imagePath),
//                       ),
//                       const SizedBox(height: 15),
//                       Text(
//                         name,
//                         style: const TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(email, style: TextStyle(color: Colors.grey[600])),
//                       Text(phone, style: TextStyle(color: Colors.grey[600])),
//                       const SizedBox(height: 20),
//                       const Divider(),
//                       ListTile(
//                         leading: const Icon(
//                           Icons.edit,
//                           color: Color(0xFF093A61),
//                         ),
//                         title: const Text("Edit Profile"),
//                         onTap: editProfile,
//                       ),
//                       ListTile(
//                         leading: const Icon(
//                           Icons.image,
//                           color: Color(0xFF093A61),
//                         ),
//                         title: const Text("Change Profile Picture"),
//                         onTap: () {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text("Connect image_picker here"),
//                             ),
//                           );
//                         },
//                       ),
//                       ListTile(
//                         leading: const Icon(
//                           Icons.help,
//                           color: Color(0xFF093A61),
//                         ),
//                         title: const Text("Help & Support"),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => const SupportPage(),
//                             ),
//                           );
//                         },
//                       ),
//                       ListTile(
//                         leading: const Icon(Icons.logout, color: Colors.red),
//                         title: const Text(
//                           "Logout",
//                           style: TextStyle(color: Colors.red),
//                         ),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (_) => const Login()),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               }

//               MaterialPageRoute(builder: (_) => const Login());
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SupportPage extends StatelessWidget {
//   const SupportPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Help & Support"),
//         backgroundColor: const Color(0xFF093A61),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               "Frequently Asked Questions",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text("• How to request a service?"),
//             Text("• How to edit my profile?"),
//             Text("• How to contact support?"),
//             SizedBox(height: 20),
//             Text(
//               "Contact Us:",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Text("Email: support@homez.com"),
//           ],
//         ),
//       ),
//     );
//   }
// // }
// import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'theme_provider.dart';
// import 'login.dart';

// class Account extends StatefulWidget {
//   final String name;
//   final String email;

//   const Account({super.key, required this.name, required this.email});

//   @override
//   State<Account> createState() => _AccountState();
// }

// class _AccountState extends State<Account> {
//   late String name;
//   late String email;
//   String phone = "000-000-0000";
//   String imagePath = "images1/avatar1.png";

//   @override
//   void initState() {
//     super.initState();
//     name = widget.name;
//     email = widget.email;
//   }

//   // دالة تعديل الملف الشخصي - منفصلة ومستقلة
//   void editProfile() {
//     TextEditingController nameController = TextEditingController(text: name);
//     TextEditingController phoneController = TextEditingController(text: phone);

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Edit Profile"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(labelText: "Name"),
//             ),
//             TextField(
//               controller: phoneController,
//               decoration: const InputDecoration(labelText: "Phone"),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 name = nameController.text;
//                 phone = phoneController.text;
//               });
//               Navigator.pop(context);
//             },
//             child: const Text("Save"),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F8FD),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 40),
//             Container(
//               width: 120,
//               height: 120,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 // لا يوجد لون خلفية
//               ),
//               clipBehavior: Clip.antiAlias,
//               child: Image.asset(imagePath, fit: BoxFit.cover),
//             ),
//             const SizedBox(height: 15),
//             Text(
//               name,
//               style: const TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFFFFB545),
//               ),
//             ),
//             Text(email, style: TextStyle(color: Colors.grey[600])),
//             Text(phone, style: TextStyle(color: Colors.grey[600])),
//             const SizedBox(height: 20),
//             const Divider(),
//             ListTile(
//               leading: const Icon(
//                 Icons.edit,
//                 color: Color(0xFFFFB545), // برتقالي
//                 size: 30,
//               ),
//               title: const Text("Edit Profile"),
//               onTap: editProfile,
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.image,
//                 color: Color(0xFF2196F3), // أزرق
//                 size: 30,
//               ),
//               title: const Text("Change Profile Picture"),
//               onTap: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("Connect image_picker here")),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.help,
//                 color: Color(0xFF4CAF50), // أخضر
//                 size: 30,
//               ),
//               title: const Text("Help & Support"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const SupportPage()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout, color: Colors.red, size: 30),
//               title: const Text("Logout", style: TextStyle(color: Colors.red)),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const Login()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SupportPage extends StatelessWidget {
//   const SupportPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Help & Support"),
//         backgroundColor: const Color(0xFF093A61),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               "Frequently Asked Questions",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text("• How to request a service?"),
//             Text("• How to edit my profile?"),
//             Text("• How to contact support?"),
//             SizedBox(height: 20),
//             Text(
//               "Contact Us:",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Text("Email: support@homez.com"),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'login.dart';

class Account extends StatefulWidget {
  final String name;
  final String email;

  const Account({super.key, required this.name, required this.email});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late String name;
  late String email;
  String phone = "000-000-0000"; 
  String imagePath = "images1/avatar1.png";

  @override
  void initState() {
    super.initState();
    name = widget.name;
    email = widget.email;
  }

  // دالة تعديل الملف الشخصي مع تصغير الخطوط وضبط الألوان
  void editProfile() {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController phoneController = TextEditingController(text: phone);

    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: const Color(0xFF093A61)),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFFFB545),
            selectionColor: Color(0x4DFFB545),
            selectionHandleColor: Color(0xFFFFB545),
          ),
        ),
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            "Edit Profile",
            style: TextStyle(
              color: Color(0xFF093A61),
              fontWeight: FontWeight.bold,
              fontSize: 18, // تصغير خط العنوان
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(color: Color(0xFF093A61), fontSize: 14), // تصغير خط الكتابة
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  labelStyle: TextStyle(color: Color(0xFF093A61), fontSize: 13),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFB545), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Color(0xFF093A61), fontSize: 14),
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  labelStyle: TextStyle(color: Color(0xFF093A61), fontSize: 13),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFB545), width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey, fontSize: 13)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF093A61),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              ),
              onPressed: () {
                setState(() {
                  name = nameController.text;
                  phone = phoneController.text;
                });
                Navigator.pop(context);
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Color(0xFFFFB545), fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // الهيدر مع الصورة كما كانت سابقاً (بدون بهذلة)
            const SizedBox(height: 40),
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
            
            const SizedBox(height: 15),
            // عرض الاسم بخط أصغر قليلاً
            Text(
              name,
              style: const TextStyle(
                fontSize: 20, // صغرنا الخط من 24 لـ 20
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFB545), // رجعت اللون البرتقالي الجميل للاسم
              ),
            ),
            const SizedBox(height: 4),
            Text(
              email,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            Text(
              phone,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            
            const SizedBox(height: 20),
            const Divider(indent: 20, endIndent: 20),
            
            // القائمة بتنسيق مرتب وخطوط ناعمة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  buildAccountTile(Icons.edit, "Edit Profile", const Color(0xFFFFB545), editProfile),
                  buildAccountTile(Icons.image, "Change Profile Picture", const Color(0xFF2196F3), () {}),
                  buildAccountTile(Icons.help, "Help & Support", const Color(0xFF4CAF50), () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportPage()));
                  }),
                  const SizedBox(height: 10),
                  buildAccountTile(Icons.logout, "Logout", Colors.red, () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const Login()),
                      (route) => false,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAccountTile(IconData icon, String title, Color iconColor, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 28),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF093A61),
          fontWeight: FontWeight.w500,
          fontSize: 15, // صغرنا خط القائمة
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: onTap,
    );
  }
}

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support", style: TextStyle(fontSize: 18)),
        backgroundColor: const Color(0xFF093A61),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Frequently Asked Questions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF093A61)),
            ),
            SizedBox(height: 15),
            Text("• How to request a service?", style: TextStyle(fontSize: 14)),
            Text("• How to edit my profile?", style: TextStyle(fontSize: 14)),
            Text("• How to contact support?", style: TextStyle(fontSize: 14)),
            SizedBox(height: 25),
            Text(
              "Contact Us:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF093A61)),
            ),
            Text("Email: support@homez.com", style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}