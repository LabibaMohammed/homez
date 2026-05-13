// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'admin_layout.dart';

// class Log_page extends StatefulWidget {
//   const Log_page({super.key});

//   @override
//   State<Log_page> createState() => _Log_pageState();
// }

// class _Log_pageState extends State<Log_page> {

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool isLoading = false;

//   Future<void> Log_page() async {
//     setState(() => isLoading = true);

//     try {
//       // 🔐 تسجيل دخول Firebase
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );

//       // 💾 حفظ حالة الدخول (SharedPreferences)
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', true);

//       // 🚀 الانتقال للـ Admin
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => AdminLayout()),
//       );

//     } on FirebaseAuthException catch (e) {

//       String message = "Login failed";

//       if (e.code == 'user-not-found') {
//         message = "User not found";
//       } else if (e.code == 'wrong-password') {
//         message = "Wrong password";
//       } else if (e.code == 'invalid-email') {
//         message = "Invalid email";
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(message)),
//       );

//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     }

//     setState(() => isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F8FD),
//       body: Center(
//         child: Container(
//           width: 350,
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(color: Colors.grey.shade300, blurRadius: 10)
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [

//               const Text(
//                 "Admin Login",
//                 style: TextStyle(
//                   color: Color(0xFF093A61),
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 20),

//               TextField(
//                 controller: emailController,
//                 cursorColor: const Color(0xFF093A61),
//                 decoration: const InputDecoration(
//                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Color(0xFF093A61)),
//                   ),
                  
                  
//                   labelText: "Email",
//                   labelStyle: TextStyle(color: Color(0xFF093A61)),
                  
//                 ),
//               ),

//               const SizedBox(height: 15),

//               TextField(
//                 controller: passwordController,
//                 cursorColor: const Color(0xFF093A61),
//                 obscureText: true,
//                 decoration: const InputDecoration(
                
                  
//                   enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Color(0xFF093A61)),
//                   ),
//                   labelText: "Password",
//                   labelStyle: TextStyle(color: Color(0xFF093A61)),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               isLoading
//                   ? const CircularProgressIndicator()
//                   : ElevatedButton(
//                       onPressed: Log_page,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFFFB545),
//                       ),
//                       child: const Text("Login",style: TextStyle(color: Colors.white),),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
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

  // دالة تسجيل الدخول
  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminLayout()),
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FD),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400, // عرض مناسب لشاشات الويب والجوال
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // الشعار (Logo)
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F8FD),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.admin_panel_settings_rounded,
                    size: 50,
                    color: Color(0xFF093A61),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Color(0xFF093A61),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Enter your admin credentials",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 40),

                // حقل البريد الإلكتروني
                TextField(
                  controller: emailController,
                  cursorColor: const Color(0xFF093A61),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF093A61)),
                    labelText: "Email Address",
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFFF2F8FD),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFF093A61)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // حقل كلمة المرور
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  cursorColor: const Color(0xFF093A61),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF093A61)),
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFFF2F8FD),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFF093A61)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // زر تسجيل الدخول
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator(color: Color(0xFF093A61)))
                      : ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFB545),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Login to Dashboard",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
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