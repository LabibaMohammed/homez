import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'admin_layout.dart';

class Log_page extends StatefulWidget {
  const Log_page({super.key});

  @override
  State<Log_page> createState() => _Log_pageState();
}

class _Log_pageState extends State<Log_page> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> Log_page() async {
    setState(() => isLoading = true);

    try {
      // 🔐 تسجيل دخول Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // 💾 حفظ حالة الدخول (SharedPreferences)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      // 🚀 الانتقال للـ Admin
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AdminLayout()),
      );

    } on FirebaseAuthException catch (e) {

      String message = "Login failed";

      if (e.code == 'user-not-found') {
        message = "User not found";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FD),
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.grey.shade300, blurRadius: 10)
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Text(
                "Admin Login",
                style: TextStyle(
                  color: Color(0xFF093A61),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                cursorColor: const Color(0xFF093A61),
                decoration: const InputDecoration(
                   enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF093A61)),
                  ),
                  
                  
                  labelText: "Email",
                  labelStyle: TextStyle(color: Color(0xFF093A61)),
                  
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: passwordController,
                cursorColor: const Color(0xFF093A61),
                obscureText: true,
                decoration: const InputDecoration(
                
                  
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF093A61)),
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Color(0xFF093A61)),
                ),
              ),

              const SizedBox(height: 20),

              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: Log_page,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFB545),
                      ),
                      child: const Text("Login",style: TextStyle(color: Colors.white),),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}