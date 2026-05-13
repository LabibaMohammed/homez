// import 'package:flutter/material.dart';
// import 'package:homez/indexpage.dart';
// import 'package:homez/sign_up.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController firstNameController = TextEditingController();
// final TextEditingController lastNameController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     loadSavedEmail(); // تحميل الإيميل المحفوظ
//     _initializeGoogleSignIn();
//   }

//   Future<void> _initializeGoogleSignIn() async {
//     await GoogleSignIn.instance.initialize();
//   }

//   // تحميل البيانات المحفوظة
//   Future<void> loadSavedEmail() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? savedEmail = prefs.getString('email');

//     if (savedEmail != null) {
//       emailController.text = savedEmail;
//     }
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

//       final UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithCredential(credential);

//       final user = userCredential.user;
//       if (user != null) {
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setBool('isLoggedIn', true);
//         await prefs.setString('email', user.email ?? "");
//         final displayName = user.displayName ?? "";
//         final displayParts = displayName.split(' ');
//         final firstName = displayParts.isNotEmpty ? displayParts.first : "";
//         final lastName = displayParts.length > 1
//             ? displayParts.sublist(1).join(' ')
//             : "";
//         await prefs.setString('firstName', firstName);
//         await prefs.setString('lastName', lastName);

//         if (!mounted) return;
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Indexpage(
//               firstName: firstName,
//               lastName: lastName,
//               email: user.email ?? "",
//             ),
//           ),
//         );
//       }
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Google Sign-In Failed")),
//       );
//     }
//   }

//   void handleLogin() async {
//   final firstName = firstNameController.text.trim();
//   final lastName = lastNameController.text.trim();
//   final email = emailController.text.trim();
//   final password = passwordController.text;

//   final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//   final passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$');

//   if (firstName.isEmpty) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Please enter your first name')),
//     );
//   } else if (email.isEmpty || password.isEmpty) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Please enter both email and password')),
//     );
//   } else if (!emailRegex.hasMatch(email)) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Please enter a valid email address')),
//     );
//   } else if (!passwordRegex.hasMatch(password)) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Password must contain letters and numbers')),
//     );
//   } else {

//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedIn', true);
//     await prefs.setString('email', email);
//     await prefs.setString('firstName', firstName);
//     await prefs.setString('lastName', lastName);

//     if (!mounted) return;
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => Indexpage(
//           firstName: firstName,
//           lastName: lastName,
//           email: email,
//         ),
//       ),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F8FD),
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(50.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Welcome',
//                   style: TextStyle(
//                     fontSize: 45,
//                     fontWeight: FontWeight.w700,
//                     color: const Color(0xFF093A61),
//                   ),
//                 ),

//                 SizedBox(height: 60),
//                 SizedBox(height: 30),

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
//                 TextField(
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     hintText: "Email",
//                     fillColor: Colors.white,
//                     filled: true,
//                     border: InputBorder.none,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     hintText: "Password",
//                     fillColor: Colors.white,
//                     filled: true,
//                     border: InputBorder.none,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 130),
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.transparent,
//                       shadowColor: Colors.transparent,
//                       elevation: 0,
//                       padding: EdgeInsets.zero,
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Signup()),
//                       );
//                     },
//                     child: Text(
//                       'New here? create an account',
//                       style: TextStyle(
//                         color: Color(0xDEF44336),
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                   ),
//                   onPressed: signInWithGoogle,
//                   icon: Icon(
//                     Icons.g_mobiledata,
//                     color: Colors.red,
//                     size: 35,
//                   ),
//                   label: Text(
//                     "Sign in with Google",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFFFB545),
//                     padding: EdgeInsets.symmetric(horizontal: 60),
//                   ),
//                   onPressed: handleLogin,
//                   child: Text(
//                     'Login',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:homez/indexpage.dart';
import 'package:homez/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    loadSavedEmail();
    _initializeGoogleSignIn();
  }

  Future<void> _initializeGoogleSignIn() async {
    await GoogleSignIn.instance.initialize();
  }

  Future<void> loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');
    if (savedEmail != null) {
      emailController.text = savedEmail;
    }
  }

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

  void handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter both email and password')));
    } else if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid email address')));
    } else {
      try {
        // تسجيل الدخول عبر فيربيز
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, 
          password: password
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('email', email);
        
        // جلب البيانات المخزنة مسبقاً (الأسماء) عند التسجيل
        String firstName = prefs.getString('firstName') ?? "User";
        String lastName = prefs.getString('lastName') ?? "";

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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login failed. Please check your credentials.')));
      }
    }
  }

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
                const SizedBox(height: 100), // زيادة المسافة العلوية لأن الحقول أصبحت أقل
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF093A61),
                  ),
                ),
                const Text(
                  'Log in to your account',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 50),

                // حقول الإيميل والباسورد فقط
                _buildTextField(
                  controller: emailController, 
                  hint: "Email", 
                  icon: Icons.email_outlined, 
                  type: TextInputType.emailAddress
                ),
                _buildTextField(
                  controller: passwordController, 
                  hint: "Password", 
                  icon: Icons.lock_outline, 
                  isPassword: true
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup()));
                    },
                    child: const Text(
                      'New here? Create an account',
                      style: TextStyle(color: Color(0xFFFFB545), fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF093A61),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 0,
                    ),
                    onPressed: handleLogin,
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 25),
                const Text("OR", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey.shade200),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: signInWithGoogle,
                    icon: Image.asset("images1/google-icon.png", height: 35),
                    label: const Text(
                      "Sign in with Google",
                      style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500),
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