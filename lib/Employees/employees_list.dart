import 'package:asset_tracker/Invoices/invoice_create.dart';
import 'package:asset_tracker/components/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class EmployeesList extends StatelessWidget {
  const EmployeesList({super.key});

  @override
  Widget build(BuildContext context) {
    Color? darkest = Colors.blueGrey[900];
    return Scaffold(
      body: Column(
        children: [
          CommonWidgets.TopBar('Employees List'),
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
                                        builder: (context) =>
                                            const InvoiceCreate(),
                                      ));
                                },
                              ),
                              _buildMenuItem(
                                Icons.edit,
                                'Edit',
                                0,
                                () {},
                              ),
                              _buildMenuItem(
                                Iconsax.import,
                                'Import',
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
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            // border: Border.all(width: 0.4),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.blueGrey[100],
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
                                        borderSide: const BorderSide(
                                            width: 0.5,
                                            color: Colors.blueGrey)),
                                    fillColor: Colors.blueGrey[50],
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(3),
                                    hintText: 'Employee Name',
                                    hintStyle: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    prefixIcon: const Icon(Icons.search),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(
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
                                        borderSide: const BorderSide(
                                            width: 0.5,
                                            color: Colors.blueGrey)),
                                    fillColor: Colors.blueGrey[50],
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(3),
                                    hintText: 'Search by Location',
                                    hintStyle: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    prefixIcon: const Icon(Icons.search),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(
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
                                        borderSide: const BorderSide(
                                            width: 0.5,
                                            color: Colors.blueGrey)),
                                    fillColor: Colors.blueGrey[50],
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(3),
                                    hintText: 'Search by Employee #',
                                    hintStyle: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    prefixIcon: const Icon(Icons.search),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey[100],
                                    border: Border.symmetric(
                                        horizontal: BorderSide(width: 0.6))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          'Employee Name',
                                          style: GoogleFonts.roboto(
                                              color: darkest,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          'Email',
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            color: darkest,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 180,
                                        child: Text(
                                          'Emp ID',
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              color: darkest,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          'Office Location',
                                          style: GoogleFonts.roboto(
                                              fontSize: 14,
                                              color: darkest,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.grey[100],
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
                                          height: 20,
                                          width: 20,
                                          child: const Icon(
                                            Iconsax.user,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          'Ismail Manneri Ebrahim',
                                          style: GoogleFonts.roboto(
                                              color: Colors.blue[800],
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          'ismail.ibrahim@acino.swiss',
                                          style: GoogleFonts.roboto(
                                            color: darkest,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 180,
                                        child: Text(
                                          'Emp# : SASL0989897',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: darkest,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          'Jeddah, Saudi Arabia',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: darkest,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.grey[300],
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
                                          height: 20,
                                          width: 20,
                                          child: const Icon(
                                            Iconsax.user,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          'Ismail Manneri Ebrahim',
                                          style: GoogleFonts.roboto(
                                              color: Colors.blue[800],
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          'ismail.ibrahim@acino.swiss',
                                          style: GoogleFonts.roboto(
                                            color: darkest,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 180,
                                        child: Text(
                                          'Emp# : SASL0989897',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: darkest,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          'Jeddah, Saudi Arabia',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: darkest,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.grey[100],
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
                                          height: 20,
                                          width: 20,
                                          child: const Icon(
                                            Iconsax.user,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          'Ismail Manneri Ebrahim',
                                          style: GoogleFonts.roboto(
                                              color: Colors.blue[800],
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          'ismail.ibrahim@acino.swiss',
                                          style: GoogleFonts.roboto(
                                            color: darkest,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 180,
                                        child: Text(
                                          'Emp# : SASL0989897',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: darkest,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          'Jeddah, Saudi Arabia',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: darkest,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.grey[300],
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
                                          height: 20,
                                          width: 20,
                                          child: const Icon(
                                            Iconsax.user,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          'Ismail Manneri Ebrahim',
                                          style: GoogleFonts.roboto(
                                              color: Colors.blue[800],
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          'ismail.ibrahim@acino.swiss',
                                          style: GoogleFonts.roboto(
                                            color: darkest,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 180,
                                        child: Text(
                                          'Emp# : SASL0989897',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: darkest,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          'Jeddah, Saudi Arabia',
                                          style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            color: darkest,
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

Widget _buildMenuItem(
    IconData icon, String title, int index, void Function() onClick) {
  return InkWell(
    onTap: onClick,
    child: Container(
      height: 45,
      padding: const EdgeInsets.all(10),
      color: Colors.transparent,
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
