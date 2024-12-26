import 'package:asset_tracker/Access%20Management/access_management_page.dart';
import 'package:asset_tracker/IT%20Updates/it_updates.dart';
import 'package:asset_tracker/asset_page.dart';
import 'package:asset_tracker/components/common_widgets.dart';
import 'package:asset_tracker/dashboard.dart';
import 'package:asset_tracker/data_class/data_class.dart';
import 'package:asset_tracker/login.dart';
import 'package:asset_tracker/task_assignment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  @override
  _LeftSideMenuAppState createState() => _LeftSideMenuAppState();
}

class _LeftSideMenuAppState extends State<HomePage> {
  int _selectedIndex = 0;

  // Create dynamic tabs method
  List<Widget> _getTabs() {
    return [
      Dashboard(),
      AssetPage(),
      AccessManagementPage(),
      ItUpdates(),
      // TaskAssignment()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CommonWidgets.TopBar(''),
          Expanded(
            child: Row(
              children: [
                // Left-side menu

                Container(
                  width: 200,
                  color: const Color.fromARGB(255, 45, 45, 45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 0.4,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            _buildMenuItem(
                                'assets/dashboard.png', 'Dashboard', 0),
                            _buildMenuItem(
                                'assets/manage.png', 'Management', 1),
                            _buildMenuItem(
                                'assets/employees.png', 'Access Management', 2),
                            _buildMenuItem(
                                'assets/communtiy.png', 'IT Updates', 3),
                            // _buildMenuItem(
                            //     'assets/task.png', 'Task Assignment', 4),
                            _buildMenuItem(
                                'assets/language.png', 'Language', 5),
                            _buildMenuItem(
                                'assets/settings.png', 'Preferences', 6),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: TextButton.icon(
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance.signOut();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("Logged out successfully!")),
                              );
                              // Navigate back to the login screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("Error logging out: $e")),
                              );
                            }
                          },
                          label: Text('Logout'),
                          icon: Icon(Iconsax.logout),
                        ),
                      )
                    ],
                  ),
                ),
                // Right-side content
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: _getTabs(), // Use dynamic tabs here
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String imagePath, String title, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          setState(() {});
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        color:
            _selectedIndex == index ? Colors.blueGrey[700] : Colors.transparent,
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 24,
            ),
            SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.roboto(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


  // Helper to build menu items
 

