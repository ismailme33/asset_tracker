import 'package:asset_tracker/components/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AssetView extends StatelessWidget {
  final dynamic assetReceived;

  const AssetView({Key? key, required this.assetReceived}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<void> _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Color? darkest = Colors.blueGrey[900];

    return Scaffold(
      body: Column(
        children: [
          CommonWidgets.TopBar('Asset'),
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
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.blueGrey[50],
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 380,
                          width: 350,
                          child: Card(
                            color: Colors.blueGrey[100],
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Device Details',
                                    style: GoogleFonts.roboto(
                                        color: darkest,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(height: 0.6, color: darkest),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      assetReceived.assetType != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Container(
                                                color: Colors.blueGrey[700],
                                                height: 35,
                                                width: 35,
                                                child: Center(
                                                  child: assetReceived
                                                              .assetType ==
                                                          'Laptop'
                                                      ? const Icon(
                                                          Icons.laptop,
                                                          color: Colors.white,
                                                          size: 20,
                                                        )
                                                      : assetReceived
                                                                  .assetType ==
                                                              'Mouse & Keyboard'
                                                          ? Icon(
                                                              Icons.keyboard,
                                                              color:
                                                                  Colors.white,
                                                              size: 20,
                                                            )
                                                          : assetReceived
                                                                      .assetType ==
                                                                  'HeadPhone'
                                                              ? Icon(
                                                                  Icons
                                                                      .headphones,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 20,
                                                                )
                                                              : assetReceived
                                                                          .assetType ==
                                                                      'iPad'
                                                                  ? Icon(
                                                                      Icons.tab,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 20,
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .settings,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 20,
                                                                    ),
                                                ),
                                              ))
                                          : SizedBox(),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            assetReceived.assetType,
                                            style: GoogleFonts.roboto(
                                                color: darkest,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'SN: ',
                                                style: GoogleFonts.roboto(
                                                    color: darkest,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                assetReceived.sn,
                                                style: GoogleFonts.roboto(
                                                    color: darkest,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.copy,
                                                size: 14,
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          'IMEI Number',
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        assetReceived.imeiNumber != ''
                                            ? assetReceived.imeiNumber
                                            : "NA",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Device Model',
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        assetReceived.deviceModel != ''
                                            ? assetReceived.deviceModel
                                            : "NA",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Processor',
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        assetReceived.processor != ''
                                            ? assetReceived.processor
                                            : "NA",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          'RAM',
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        assetReceived.ram != ''
                                            ? assetReceived.ram
                                            : "NA",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Hard Drive',
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          assetReceived.hardDrive != ''
                                              ? assetReceived.hardDrive
                                              : "NA",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Display Size',
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        assetReceived.displaySize != ''
                                            ? assetReceived.displaySize
                                            : "NA",
                                        style: GoogleFonts.roboto(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    'Warranty Details',
                                    style: GoogleFonts.roboto(
                                      color: Colors.blueGrey[500],
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Text(
                                      //       'Start: 20 Nov 21',
                                      //       style: GoogleFonts.roboto(
                                      //         color: Colors.grey[700],
                                      //         fontSize: 11,
                                      //       ),
                                      //     ),
                                      //     Text(
                                      //       'End: 20 Nov 24',
                                      //       style: GoogleFonts.roboto(
                                      //         color: Colors.grey[700],
                                      //         fontSize: 11,
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Container(
                                      //       height: 5,
                                      //       width: 100,
                                      //       color: Colors.green,
                                      //     ),
                                      //     Container(
                                      //       height: 5,
                                      //       width: 212,
                                      //       color: Colors.grey,
                                      //     )
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       'Waranty Remaining:',
                                      //       style: GoogleFonts.roboto(
                                      //           fontSize: 13,
                                      //           fontWeight: FontWeight.w500),
                                      //     ),
                                      //     SizedBox(
                                      //       width: 10,
                                      //     ),
                                      //     Text(
                                      //       '2 Years 6 Months',
                                      //       style: GoogleFonts.roboto(
                                      //           color: Colors.green,
                                      //           fontSize: 13,
                                      //           fontWeight: FontWeight.w500),
                                      //     ),
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   height: 20,
                                      // ),
                                      if (assetReceived.assetType == 'Laptop')
                                        TextButton(
                                            style: TextButton.styleFrom(
                                                overlayColor: Colors.blue[900],
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0)),
                                            onPressed: () {
                                              _launchURL(
                                                  'https://pcsupport.lenovo.com/us/en');
                                            },
                                            child: Text(
                                              'Check Warranty Online',
                                              style: GoogleFonts.roboto(),
                                            )),

                                      if (assetReceived.assetType == 'iPad')
                                        TextButton(
                                            style: TextButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0)),
                                            onPressed: () {
                                              _launchURL(
                                                  'https://checkcoverage.apple.com/?locale=en_SA');
                                            },
                                            child: Text(
                                              'Check Warranty Online',
                                              style: GoogleFonts.roboto(),
                                            ))
                                      else
                                        SizedBox()
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            height: 380,
                            width: 370,
                            child: Card(
                              color: Colors.blueGrey[100],
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Other Details',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: darkest,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 0.6,
                                      color: Colors.blueGrey[800],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Container(
                                              color: Colors.blueGrey[600],
                                              height: 35,
                                              width: 35,
                                              child: Center(
                                                child: Icon(
                                                  Icons.info_outline_rounded,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Status       :  ',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  assetReceived.status != ''
                                                      ? assetReceived.status
                                                      : "NA",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1,
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Sub Status  :   ',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      assetReceived.substatus !=
                                                              ''
                                                          ? assetReceived
                                                              .substatus
                                                          : "NA",
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            'Assigned ',
                                            style: GoogleFonts.roboto(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          width: 220,
                                          child: Text(
                                            assetReceived.assignee != ''
                                                ? assetReceived.assignee
                                                : "NA",
                                            style: GoogleFonts.roboto(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            'Assigned date',
                                            style: GoogleFonts.roboto(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          assetReceived.assignedDate != null
                                              ? DateFormat('dd-MMM-yyyy')
                                                  .format(assetReceived
                                                      .assignedDate)
                                              : "NA",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            'Local IT Site',
                                            style: GoogleFonts.roboto(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          assetReceived.localITSite != ''
                                              ? assetReceived.localITSite
                                              : "NA",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            'Location',
                                            style: GoogleFonts.roboto(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          assetReceived.location != ''
                                              ? assetReceived.location
                                              : "NA",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            'Legal Entity',
                                            style: GoogleFonts.roboto(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          assetReceived.legalentity != ''
                                              ? assetReceived.legalentity
                                              : "NA",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            'Supplier',
                                            style: GoogleFonts.roboto(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          width: 220,
                                          child: Text(
                                            assetReceived.supplier != ''
                                                ? assetReceived.supplier
                                                : "NA",
                                            style: GoogleFonts.roboto(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            'Purchased Date',
                                            style: GoogleFonts.roboto(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          assetReceived.purchasedDate != null
                                              ? DateFormat('dd-MMM-yyyy')
                                                  .format(assetReceived
                                                      .purchasedDate)
                                              : "NA",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            'Created Date',
                                            style: GoogleFonts.roboto(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          assetReceived.createdDate != null
                                              ? DateFormat('dd-MMM-yyyy')
                                                  .format(
                                                      assetReceived.createdDate)
                                              : "NA",
                                          style: GoogleFonts.roboto(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
