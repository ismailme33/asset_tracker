import 'dart:async';

import 'package:asset_tracker/home_page.dart';
import 'package:asset_tracker/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeFirebaseAndNavigate();
  }

  Future<void> _initializeFirebaseAndNavigate() async {
    // Ensure Firebase is initialized
    await Firebase.initializeApp();

    // Wait for 3 seconds before navigation
    await Future.delayed(Duration(seconds: 2));

    final _auth = FirebaseAuth.instance;

    // Check authentication status and navigate
    if (_auth.currentUser == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show the confirmation dialog
        bool shouldExit = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Exit Confirmation'),
                content: Text('Are you sure you want to exit the app?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Exit'),
                  ),
                ],
              ),
            ) ??
            false; // Default to false if dialog is dismissed

        return shouldExit;
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey[700],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.blueGrey[800],
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          'assets/acino.png', // Path to your PNG file
                          // width: 100, // Adjust size as needed
                          height: 55,
                          fit: BoxFit.contain, // Control how the image fits
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        'Welcome to',
                        style: GoogleFonts.roboto(
                            color: Colors.grey[300],
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Asset Tracker',
                        style: GoogleFonts.roboto(
                            color: Colors.grey[300],
                            fontSize: 40,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500),
                      ),

                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'intializing...',
                        style: GoogleFonts.roboto(
                            color: Colors.grey[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      // Text(
                      //   'by Ismail Ibrahim',
                      //   style: GoogleFonts.roboto(
                      //     color: Colors.grey,
                      //     fontSize: 14,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
