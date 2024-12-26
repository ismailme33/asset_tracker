import 'package:asset_tracker/components/btext_field.dart';
import 'package:asset_tracker/components/common_widgets.dart';
import 'package:asset_tracker/components/onscreen_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class InvoiceCreate extends StatelessWidget {
  const InvoiceCreate({super.key});

  @override
  Widget build(BuildContext context) {
    Color? darkest = Colors.blueGrey[900];
    return Scaffold(
      body: Column(
        children: [
          CommonWidgets.TopBar('Invoice'),
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
                                Icons.print,
                                'Print',
                                0,
                                () {},
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
                    padding: const EdgeInsets.all(3.0),
                    color: Colors.blueGrey[50],
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 470,
                          child: Card(
                            color: Colors.blueGrey[100],
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 350,
                                    child: Text(
                                      'Invoice Details',
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 350,
                                    child: BTextField(
                                        hintText: 'Enter Invoice number',
                                        label: 'Invoice #',
                                        onChanged: (j) {}),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 350,
                                    child: BTextField(
                                        label: 'Purchase Date',
                                        onChanged: (j) {}),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 350,
                                    child: BTextField(
                                        label: 'Location', onChanged: (j) {}),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 350,
                                    child: BTextField(
                                        label: 'Local IT Site',
                                        onChanged: (j) {}),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 350,
                                    child: BTextField(
                                        label: 'Supplier', onChanged: (j) {}),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 350,
                                    child: BTextField(
                                        hintText:
                                            'Eneter each Serial number on each line',
                                        textFieldHeight: 6,
                                        label: 'SN List',
                                        onChanged: (j) {}),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'Supported File: PDF only',
                                    style: GoogleFonts.roboto(
                                        fontSize: 12, color: Colors.grey[700]),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton.icon(
                                          icon: Icon(
                                            Iconsax.receipt,
                                            size: 18,
                                          ),
                                          onPressed: () {},
                                          label: Text('Upload Invoice')),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.save,
                                            size: 18,
                                          ),
                                          onPressed: () {},
                                          label: Text('Save'))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: double.infinity,
                          child: Card(
                            color: Colors.blueGrey[100],
                          ),
                        ))
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
