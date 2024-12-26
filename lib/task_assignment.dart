import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskAssignment extends StatelessWidget {
  const TaskAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blueGrey[200]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Receive New Laptops',
                            style: GoogleFonts.roboto(
                                color: Colors.blueGrey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                            'Created: Ismail Ibrahim',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.blueGrey[800],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Done',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Colors.green[800],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '''Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor''',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
