import 'package:asset_tracker/Invoices/invoice_create.dart';
import 'package:asset_tracker/components/btext_field.dart';
import 'package:asset_tracker/components/common_widgets.dart';
import 'package:asset_tracker/components/onscreen_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class InvoiceList extends StatelessWidget {
  const InvoiceList({super.key});

  @override
  Widget build(BuildContext context) {
    Color? darkest = Colors.blueGrey[900];
    return Scaffold(
      body: Column(
        children: [
          CommonWidgets.TopBar('Invoice List'),
          Expanded(
            child: Row(
              children: [
                // Left-side menu
                Container(
                  width: 200, // Fixed width for the menu
                  color: Colors.blueGrey[900],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // List of menu items
                      Expanded(
                        child: Expanded(
                          child: ListView(
                            children: [
                              _buildMenuItem(
                                Icons.arrow_back,
                                'Back',
                                0,
                                () {
                                  Navigator.pop(context);
                                },
                              ),
                              _buildMenuItem(
                                Icons.add,
                                'New',
                                0,
                                () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => InvoiceCreate(),
                                      ));
                                },
                              ),
                              _buildMenuItem(
                                Icons.edit,
                                'Edit',
                                0,
                                () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Right-side content with tabs
                Expanded(
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            // border: Border.all(width: 0.4),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.blueGrey[300],
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 30,
                                width: 220,
                                child: TextField(
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(3),
                                        borderSide: BorderSide(
                                            width: 0.5,
                                            color: Colors.blueGrey)),
                                    fillColor: Colors.blueGrey[50],
                                    filled: true,
                                    contentPadding: EdgeInsets.all(3),
                                    hintText: 'Search Invoice #',
                                    hintStyle: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                height: 30,
                                width: 220,
                                child: TextField(
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(3),
                                        borderSide: BorderSide(
                                            width: 0.5,
                                            color: Colors.blueGrey)),
                                    fillColor: Colors.blueGrey[50],
                                    filled: true,
                                    contentPadding: EdgeInsets.all(3),
                                    hintText: 'Serial Serial Number',
                                    hintStyle: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                height: 30,
                                width: 220,
                                child: TextField(
                                  onChanged: (value) {},
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(3),
                                        borderSide: BorderSide(
                                            width: 0.5,
                                            color: Colors.blueGrey)),
                                    fillColor: Colors.blueGrey[50],
                                    filled: true,
                                    contentPadding: EdgeInsets.all(3),
                                    hintText: 'Serch by Location',
                                    hintStyle: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.blueGrey[300],
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  color: Colors.blueGrey[100],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Container(
                                            color: Colors.blueGrey[700],
                                            height: 35,
                                            width: 35,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Invoice#',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  color: Colors.blueGrey[300],
                                                ),
                                              ),
                                              Text(
                                                '254802575',
                                                style: GoogleFonts.roboto(
                                                    color: darkest,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Purchase Date',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  color: Colors.blueGrey[300],
                                                ),
                                              ),
                                              Text(
                                                '12-Nov-2024',
                                                style: GoogleFonts.roboto(
                                                  color: darkest,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 220,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Supplier',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  color: Colors.blueGrey[300],
                                                ),
                                              ),
                                              Text(
                                                '',
                                                style: GoogleFonts.roboto(
                                                  color: darkest,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildMenuItem(IconData icon, String title, int index, void onClick()) {
  return InkWell(
    onTap: onClick,
    child: Container(
      height: 45,
      padding: EdgeInsets.all(10),
      color: Colors.transparent,
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
