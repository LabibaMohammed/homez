import 'package:flutter/material.dart';
import 'package:homez/indexpage.dart';
import 'package:homez/sign_up.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void handleLogin() {
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF093A61),
                ),
              ),
              SizedBox(height: 60),
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
              
              Padding(
                padding: const EdgeInsets.only(right: 130),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: const Color(0x00757171),
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        padding: EdgeInsets.all(0)),
                    onPressed: () {
                      Navigator.push(
                        context,MaterialPageRoute(builder: (context) => Signup()),
                      );
                    },
                    child: Text(
                      'New here? create an account',
                      style: TextStyle(
                          color: const Color(0xDEF44336), fontSize: 12),
                    )),
              ),
              SizedBox(
                height: 5,
              ),
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
            ]),
          ),
        ),
      ),
    );
  }
}