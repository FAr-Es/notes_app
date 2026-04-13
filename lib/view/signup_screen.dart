import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/view/create_note.dart';
import 'package:notes_app/view/custom_button.dart';
import 'package:notes_app/view/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late bool passwordVisible;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  File? profileImage;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        profileImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 247, 247),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 64),

            // Title
            const Text(
              "Create Account",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: -.8,
                color: Color(0xFF0D1C1C),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Start organizing your thoughts today.",
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 125, 139, 158),
                letterSpacing: -.5,
              ),
            ),

            const SizedBox(height: 24),

            // Profile Image Picker
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 52,
                      backgroundColor: const Color.fromARGB(255, 220, 225, 228),
                      backgroundImage: profileImage != null
                          ? FileImage(profileImage!)
                          : null,
                      child: profileImage == null
                          ? const Icon(
                              Icons.person,
                              size: 52,
                              color: Color.fromARGB(255, 150, 162, 175),
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 11, 217, 217),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Name field
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: nameController,
              hintText: "Full Name",
              borderColor: const Color.fromARGB(255, 199, 199, 199),
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 151, 166, 186),
              ),
            ),

            const SizedBox(height: 20),

            // Email field
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: emailController,
              hintText: "Email Address",
              borderColor: const Color.fromARGB(255, 199, 199, 199),
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 151, 166, 186),
              ),
            ),

            const SizedBox(height: 20),

            // Password field
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: passwordController,
              obscureText: !passwordVisible,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 151, 166, 186),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 199, 199, 199),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 199, 199, 199),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 199, 199, 199),
                    width: 2,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: const Color.fromARGB(255, 151, 166, 186),
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Register button
            CustomButton(
              text: "Register",
              onTap: () async {
                if (nameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                  return;
                }

                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                  await FirebaseAuth.instance.currentUser?.updateDisplayName(
                    nameController.text.trim(),
                  );

                  if (!context.mounted) return;
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CreateNote()));
                } on FirebaseAuthException catch (e) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message ?? 'Registration failed')),
                  );
                }
              },
            ),

            const SizedBox(height: 24),

            // OR CONTINUE WITH divider
            Row(
              children: const [
                Expanded(
                  child: Divider(color: Color.fromARGB(255, 199, 199, 199)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    "OR CONTINUE WITH",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 151, 166, 186),
                      letterSpacing: .5,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(color: Color.fromARGB(255, 199, 199, 199)),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Google & Facebook buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) =>
                            const Center(child: CircularProgressIndicator()),
                      );

                      final userCredential = await signInWithGoogle();

                      if (!context.mounted) return;
                      Navigator.pop(context); // Dismiss loading

                      if (userCredential != null) {
                        // Navigate to your home/notes screen
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CreateNote(),));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Google sign-in failed. Please try again.',
                            ),
                          ),
                        );
                      }
                    },
                    icon: Image.network(
                      'https://icon2.cleanpng.com/20240216/fty/transparent-google-logo-flat-google-logo-with-blue-green-red-1710875585155.webp',
                      width: 20,
                      height: 20,
                    ),
                    label: const Text(
                      "Google",
                      style: TextStyle(
                        color: Color(0xFF0D1C1C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 199, 199, 199),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.facebook,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: const Text(
                      "Facebook",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1877F2),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Already have account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 123, 138, 158),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Color.fromARGB(255, 11, 217, 217),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

Future<UserCredential?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // User cancelled the sign-in dialog
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on FirebaseAuthException catch (e) {
    debugPrint('FirebaseAuthException: ${e.message}');
    return null;
  } catch (e) {
    debugPrint('Google Sign-In error: $e');
    return null;
  }
}