import 'package:flutter/material.dart';
import 'package:homez/indexpage.dart';
import 'package:shared_preferences/shared_preferences.dart'; // إضافة SharedPreferences

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void handleSignup() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$');

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    } else if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter a valid email address')),
      );
    } else if (!passwordRegex.hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must contain letters and numbers')),
      );
    } else {
      // حفظ الإيميل فقط
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('email', email);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Indexpage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FD),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF093A61),
              ),
            ),
            SizedBox(height: 40),
            TextSelectionTheme(
              data: TextSelectionThemeData(
                cursorColor: const Color(0xFF093A61),
                selectionHandleColor: const Color(0xFF093A61),
              ),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            SizedBox(height: 10),
            TextSelectionTheme(
              data: TextSelectionThemeData(
                cursorColor: const Color(0xFF093A61),
                selectionHandleColor: const Color(0xFF093A61),
              ),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFB545),
                padding: EdgeInsets.symmetric(horizontal: 40),
              ),
              onPressed: handleSignup,
              child: Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}