import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'login.dart'; // عدلي المسار حسب مشروعك

class Account extends StatefulWidget {
  final String name;
  final String email;

  const Account({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late String name;
  late String email;
  String phone = "000-000-0000"; // قيمة افتراضية
  String imagePath = "images1/avatar1.png";

  

  @override
  void initState() {
    super.initState();
    name = widget.name;
    email = widget.email;
  }

  // دالة تعديل الملف الشخصي
  void editProfile() {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController phoneController = TextEditingController(text: phone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                name = nameController.text;
                phone = phoneController.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
  backgroundColor: const Color(0xFF093A61),
  title: const Text("My Account"),
  actions: [
    Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => IconButton(
        icon: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
        onPressed: () {
          themeProvider.toggleTheme(); // هذا يغيّر الثيم للتطبيق كله
        },
      ),
    ),
  ],
),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // صورة الحساب
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(height: 15),

            // الاسم
            Text(
              name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            // الإيميل
            Text(
              email,
              style: TextStyle(color: Colors.grey[600]),
            ),

            // رقم الهاتف
            Text(
              phone,
              style: TextStyle(color: Colors.grey[600]),
            ),

            const SizedBox(height: 20),
            const Divider(),

            // تعديل الملف الشخصي
            ListTile(
              leading: const Icon(Icons.edit, color: Color(0xFF093A61)),
              title: const Text("Edit Profile"),
              onTap: editProfile,
            ),

            // تغيير الصورة (مكان إضافة image_picker لاحقًا)
            ListTile(
              leading: const Icon(Icons.image, color: Color(0xFF093A61)),
              title: const Text("Change Profile Picture"),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Connect image_picker here")),
                );
              },
            ),

            // دعم/مساعدة
            ListTile(
              leading: const Icon(Icons.help, color: Color(0xFF093A61)),
              title: const Text("Help & Support"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SupportPage()),
                );
              },
            ),

            // تفضيلات التطبيق
            // SwitchListTile(
            //   activeColor: const Color(0xFF093A61),
            //   title: const Text("Dark Mode"),
            //   value: isDarkMode,
            //   onChanged: (value) {
            //     setState(() {
            //       isDarkMode = value;
            //     });
            //   },
            // ),

            // تسجيل الخروج
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Login()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support"),
        backgroundColor: const Color(0xFF093A61),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Frequently Asked Questions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("• How to request a service?"),
            Text("• How to edit my profile?"),
            Text("• How to contact support?"),
            SizedBox(height: 20),
            Text(
              "Contact Us:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("Email: support@homez.com"),
          ],
        ),
      ),
    );
  }
}