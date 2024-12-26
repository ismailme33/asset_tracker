import 'package:asset_tracker/asset_new_page.dart';
import 'package:asset_tracker/components/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ItUpdates extends StatelessWidget {
  const ItUpdates({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        borderRadius: BorderRadius.circular(4)),
                    width: 700,
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            'Create Post',
                            style:
                                GoogleFonts.roboto(fontWeight: FontWeight.bold),
                          ),
                          width: double.infinity,
                          color: Colors.blueGrey[200],
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              style: TextStyle(),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                prefixIcon: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    color: Colors.blueGrey,
                                    width: 30,
                                    height: 30,
                                    child: Center(
                                      child: Icon(
                                        Iconsax.user,
                                        size: 19,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                hintText: 'Write something to post..',
                                prefix: Padding(
                                  padding: EdgeInsets.all(10),
                                ),
                                border:
                                    InputBorder.none, // Removes the underline
                                enabledBorder: InputBorder
                                    .none, // Ensures it's removed even when enabled
                                focusedBorder: InputBorder
                                    .none, // Ensures it's removed when focused
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: 700,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.blueGrey[100],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    color: Colors.blueGrey,
                                    width: 30,
                                    height: 30,
                                    child: Center(
                                      child: Icon(
                                        Iconsax.user,
                                        size: 19,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ismail Ibrahim',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '12-Nov-2024 11:10 AM',
                                      style: GoogleFonts.roboto(fontSize: 10),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Icon(Icons.more_vert)
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.''',
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: Icon(
                                      Icons.thumb_up,
                                      size: 9,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '0',
                                  style: GoogleFonts.roboto(),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            Text(
                              '0 Comments',
                              style: GoogleFonts.roboto(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.blueGrey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              size: 16,
                              color: Colors.grey[900],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Like',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              Icons.comment,
                              size: 16,
                              color: Colors.grey[900],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Comment',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: 700,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.blueGrey[100],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    color: Colors.blueGrey,
                                    width: 30,
                                    height: 30,
                                    child: Center(
                                      child: Icon(
                                        Iconsax.user,
                                        size: 19,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Limbaga Verna',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '12-Nov-2024 11:10 AM',
                                      style: GoogleFonts.roboto(fontSize: 10),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Icon(Icons.more_vert)
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.''',
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 500),
                          child: Image.asset(
                            'assets/know.jpg',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: Icon(
                                      Icons.thumb_up,
                                      size: 9,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '0',
                                  style: GoogleFonts.roboto(),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            Text(
                              '0 Comments',
                              style: GoogleFonts.roboto(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.blueGrey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              size: 16,
                              color: Colors.grey[900],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Like',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              Icons.comment,
                              size: 16,
                              color: Colors.grey[900],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Comment',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: 700,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.blueGrey[100],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                    color: Colors.blueGrey,
                                    width: 30,
                                    height: 30,
                                    child: Center(
                                      child: Icon(
                                        Iconsax.user,
                                        size: 19,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ismail Ibrahim',
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '12-Nov-2024 11:10 AM',
                                      style: GoogleFonts.roboto(fontSize: 10),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Icon(Icons.more_vert)
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.''',
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 500),
                          child: Image.asset(
                            'assets/ms.jpeg',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: Icon(
                                      Icons.thumb_up,
                                      size: 9,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '0',
                                  style: GoogleFonts.roboto(),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            Text(
                              '0 Comments',
                              style: GoogleFonts.roboto(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 0.5,
                          color: Colors.blueGrey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              size: 16,
                              color: Colors.grey[900],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Like',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Icon(
                              Icons.comment,
                              size: 16,
                              color: Colors.grey[900],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Comment',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
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
