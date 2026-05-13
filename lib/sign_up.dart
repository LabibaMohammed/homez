// import 'package:flutter/material.dart';
// import 'package:homez/indexpage.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // إضافة SharedPreferences
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart'; // إضافة Google Sign-In

// class Signup extends StatefulWidget {
//   const Signup({super.key});

//   @override
//   State<Signup> createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _initializeGoogleSignIn();
//   }

//   Future<void> _initializeGoogleSignIn() async {
//     await GoogleSignIn.instance.initialize();
//   }

//   Future<void> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount googleUser =
//           await GoogleSignIn.instance.authenticate();

//       final GoogleSignInAuthentication googleAuth =
//           googleUser.authentication;

//       final credential = GoogleAuthProvider.credential(
//         idToken: googleAuth.idToken,
//       );

//     UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithCredential(
//       credential,
//     );

//     final user = userCredential.user;

//     if (user != null) {
//       final prefs = await SharedPreferences.getInstance();

//       await prefs.setBool('isLoggedIn', true);
//       await prefs.setString('email', user.email ?? "");

//       if (!mounted) return;
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Indexpage(
//             firstName: user.displayName ?? "",
//             lastName: "",
//             email: user.email ?? "",
//           ),
//         ),
//       );
//     }
//   } catch (e) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Google Sign-In Failed")),
//     );
//   }
// }

//   void handleSignup() async {
//     final firstName = firstNameController.text.trim();
//     final lastName = lastNameController.text.trim();
//     final email = emailController.text.trim();
//     final password = passwordController.text;

//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     final passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$');

//     if (email.isEmpty || password.isEmpty || firstName.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill in all fields (First Name required)')),
//       );
//       return;
//     } else if (!emailRegex.hasMatch(email)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Enter a valid email address')),
//       );
//       return;
//     } else if (!passwordRegex.hasMatch(password)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Password must contain letters and numbers')),
//       );
//       return;
//     }

//     try {
//       // Firebase Authentication
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Save login state and email
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', true);
//       await prefs.setString('email', email);

//       if (!mounted) return;
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Indexpage(
//             firstName: firstName,
//             lastName: lastName,
//             email: email,
//           ),
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       String message = 'Signup failed';
//       if (e.code == 'email-already-in-use') {
//         message = 'This email is already in use';
//       } else if (e.code == 'weak-password') {
//         message = 'The password is too weak';
//       } else if (e.code == 'invalid-email') {
//         message = 'Invalid email address';
//       }
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(message)),
//       );
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred. Please try again.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F8FD),
//       body: Padding(
//         padding: const EdgeInsets.all(40.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Sign Up',
//               style: TextStyle(
//                 fontSize: 35,
//                 fontWeight: FontWeight.w500,
//                 color: const Color(0xFF093A61),
//               ),
//             ),
//             SizedBox(height: 40),
//             SizedBox(height: 30),

// TextField(
//   controller: firstNameController,
//   decoration: InputDecoration(
//     hintText: "First Name",
//     fillColor: Colors.white,
//     filled: true,
//     border: InputBorder.none,
//   ),
// ),

// SizedBox(height: 10),

// TextField(
//   controller: lastNameController,
//   decoration: InputDecoration(
//     hintText: "Last Name (Optional)",
//     fillColor: Colors.white,
//     filled: true,
//     border: InputBorder.none,
//   ),
// ),

// SizedBox(height: 10),
//             TextSelectionTheme(
//               data: TextSelectionThemeData(
//                 cursorColor: const Color(0xFF093A61),
//                 selectionHandleColor: const Color(0xFF093A61),
//               ),
              
              
//               child: TextField(
//                 controller: emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   hintText: 'Email',
//                   hintStyle: TextStyle(color: Colors.grey),
//                   enabledBorder: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextSelectionTheme(
//               data: TextSelectionThemeData(
//                 cursorColor: const Color(0xFF093A61),
//                 selectionHandleColor: const Color(0xFF093A61),
//               ),
//               child: TextField(
//                 controller: passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   hintText: 'Password',
//                   hintStyle: TextStyle(color: Colors.grey),
//                   enabledBorder: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//            SizedBox(height: 15),

// ElevatedButton.icon(
//   style: ElevatedButton.styleFrom(
//     backgroundColor: Colors.white,
//     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//   ),
//   onPressed: signInWithGoogle,
//   icon: Icon(
//     Icons.g_mobiledata,
//     color: Colors.red,
//     size: 35,
//   ),
//   label: Text(
//     "Sign in with Google",
//     style: TextStyle(
//       color: Colors.black,
//       fontSize: 16,
//     ),
//   ),
// ),
//           ],
//         ),
//       ),
//     );
//   }
// }import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:homez/indexpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeGoogleSignIn();
  }

  Future<void> _initializeGoogleSignIn() async {
    await GoogleSignIn.instance.initialize();
  }

  // نفس دالة قوقل الموجودة في اللوقن لضمان التناسق
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('email', user.email ?? "");
        
        final displayName = user.displayName ?? "";
        final displayParts = displayName.split(' ');
        final firstName = displayParts.isNotEmpty ? displayParts.first : "";
        final lastName = displayParts.length > 1 ? displayParts.sublist(1).join(' ') : "";
        
        await prefs.setString('firstName', firstName);
        await prefs.setString('lastName', lastName);

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Indexpage(
              firstName: firstName,
              lastName: lastName,
              email: user.email ?? "",
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Google Sign-In Failed")),
      );
    }
  }

  void handleSignup() async {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$');

    if (firstName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your first name')));
    } else if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
    } else if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid email address')));
    } else if (!passwordRegex.hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password must contain letters and numbers')));
    } else {
      try {
        // إنشاء الحساب في Firebase
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('email', email);
        await prefs.setString('firstName', firstName);
        await prefs.setString('lastName', lastName);

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Indexpage(
              firstName: firstName,
              lastName: lastName,
              email: email,
            ),
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  // نفس الـ Widget المساعد المستخدم في اللوقن لتوحيد التصميم
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    TextInputType type = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: type,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF093A61)),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FD),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              children: [
                const SizedBox(height: 70),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF093A61),
                  ),
                ),
                const Text(
                  'Create your new account',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 40),

                _buildTextField(controller: firstNameController, hint: "First Name", icon: Icons.person_outline),
                _buildTextField(controller: lastNameController, hint: "Last Name (Optional)", icon: Icons.people_outline),
                _buildTextField(controller: emailController, hint: "Email", icon: Icons.email_outlined, type: TextInputType.emailAddress),
                _buildTextField(controller: passwordController, hint: "Password", icon: Icons.lock_outline, isPassword: true),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context); // العودة لصفحة اللوقن
                    },
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(color: Color(0xFFFFB545), fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // زر التسجيل الأساسي (بنفس ستايل زر اللوقن)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF093A61),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 0,
                    ),
                    onPressed: handleSignup,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Text("OR", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 20),

                // زر تسجيل الدخول بقوقل (مطابق تماماً لصفحة اللوقن)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey.shade200),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 0,
                    ),
                    onPressed: signInWithGoogle,
                    icon: Image.asset("images1/google-icon.png", height: 40),
                    label: const Text(
                      "Sign up with Google",
                      style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}