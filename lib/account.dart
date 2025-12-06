import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;

  const Account({
    Key? key,
    required this.name,
    required this.email,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('images1/avatar1.png', height: 200, width: 200),
                const SizedBox(height: 10),
                Text(
                  ' Dawad',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('Dawad22@gmail.com', style: TextStyle(color: Colors.grey[700])),
                const Divider(height: 30),

                const SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.settings, color: const Color(0xFF093A61)),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF093A61),
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.safety_check,
                    color: const Color(0xFF093A61),
                  ),
                  title: Text(
                    'Security Notifications',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF093A61),
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.account_box_rounded,
                    color: const Color(0xFF093A61),
                  ),
                  title: Text(
                    'Add new account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF093A61),
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.delete, color: const Color(0xFF093A61)),
                  title: Text(
                    'Delete this account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF093A61),
                    ),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: const Color(0xFF093A61)),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF093A61),
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
