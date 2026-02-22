import 'package:flutter/material.dart';
import 'package:homez/indexpage.dart';
import 'package:homez/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSavedEmail(); // تحميل الإيميل المحفوظ
  }

  // تحميل البيانات المحفوظة
  Future<void> loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');

    if (savedEmail != null) {
      emailController.text = savedEmail;
    }
  }

  void handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$');

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both email and password')),
      );
    } else if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address')),
      );
    } else if (!passwordRegex.hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must contain letters and numbers')),
      );
    } else {
      // ✅ حفظ البيانات في SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('email', email);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Indexpage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FD),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF093A61),
                  ),
                ),
                SizedBox(height: 60),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    fillColor: Colors.white,
                    filled: true,
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    fillColor: Colors.white,
                    filled: true,
                    border: InputBorder.none,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 130),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                      );
                    },
                    child: Text(
                      'New here? create an account',
                      style: TextStyle(
                        color: Color(0xDEF44336),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB545),
                    padding: EdgeInsets.symmetric(horizontal: 60),
                  ),
                  onPressed: handleLogin,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}