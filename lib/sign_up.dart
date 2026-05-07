import 'package:flutter/material.dart';
import 'package:homez/indexpage.dart';
import 'package:shared_preferences/shared_preferences.dart'; // إضافة SharedPreferences
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart'; // إضافة Google Sign-In

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

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser =
          await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    final user = userCredential.user;

    if (user != null) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('email', user.email ?? "");

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Indexpage(
            firstName: user.displayName ?? "",
            lastName: "",
            email: user.email ?? "",
          ),
        ),
      );
    }
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Google Sign-In Failed")),
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

    if (email.isEmpty || password.isEmpty || firstName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields (First Name required)')),
      );
      return;
    } else if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter a valid email address')),
      );
      return;
    } else if (!passwordRegex.hasMatch(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must contain letters and numbers')),
      );
      return;
    }

    try {
      // Firebase Authentication
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save login state and email
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('email', email);

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
    } on FirebaseAuthException catch (e) {
      String message = 'Signup failed';
      if (e.code == 'email-already-in-use') {
        message = 'This email is already in use';
      } else if (e.code == 'weak-password') {
        message = 'The password is too weak';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address';
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
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
            SizedBox(height: 30),

TextField(
  controller: firstNameController,
  decoration: InputDecoration(
    hintText: "First Name",
    fillColor: Colors.white,
    filled: true,
    border: InputBorder.none,
  ),
),

SizedBox(height: 10),

TextField(
  controller: lastNameController,
  decoration: InputDecoration(
    hintText: "Last Name (Optional)",
    fillColor: Colors.white,
    filled: true,
    border: InputBorder.none,
  ),
),

SizedBox(height: 10),
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
           SizedBox(height: 15),

ElevatedButton.icon(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  ),
  onPressed: signInWithGoogle,
  icon: Icon(
    Icons.g_mobiledata,
    color: Colors.red,
    size: 35,
  ),
  label: Text(
    "Sign in with Google",
    style: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}