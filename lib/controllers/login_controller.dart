import 'package:asset_tracker/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser(
      String user, String password, BuildContext context) async {
    await _auth
        .signInWithEmailAndPassword(email: user, password: password)
        .then((Value) {
      // After successful login, navigate to HomePage
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User Successfully signed in')));
    }).onError((error, StackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 2), content: Text('Error $error')));
    });
  }
}
