import 'package:diary/navigationbar/navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<void> signInwithGoogle(BuildContext context) async {
    // Begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    if (gUser != null) {
      // Obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential for the user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      try {
        // Sign in the user with the credential
        await FirebaseAuth.instance.signInWithCredential(credential);

        // Navigate to BottonNavBar
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottonNavBar()),
        );
      } catch (e) {
        // Handle sign-in errors
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Colors.deepPurple,
              title: Center(
                child: Text(
                  'Sign-in Error',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        );
      }
    }
  }
}
