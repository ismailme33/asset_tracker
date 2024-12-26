import 'package:asset_tracker/data_class/data_class.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isLoading = false;

  // Variables to store counts
  int laptopCount = 0;
  int iPadcount = 0;
  int mouseKeyboardCount = 0;
  int headPhone = 0;

  @override
  void initState() {
    super.initState();
    _loadAssetCounts();
  }

  Future<void> _loadAssetCounts() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      var fetchedCounts = await AssetsListItems().fetchAssetCountsByType();

      // Store the fetched counts into individual variables
      setState(() {
        laptopCount = fetchedCounts['Laptop'] ?? 0;
        iPadcount = fetchedCounts['iPad'] ?? 0;
        mouseKeyboardCount = fetchedCounts['Mouse & Keyboard'] ?? 0;
        headPhone = fetchedCounts['HeadPhone'] ?? 0;

        isLoading = false; // Hide loading indicator
      });
    } catch (e) {
      debugPrint("Error loading asset counts: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? darkest = Colors.blueGrey[900];

    Color? dark2 = const Color.fromARGB(255, 61, 68, 71);

    Color? mediumDark = Colors.blueGrey[200];

    Color? lightcolor = Colors.blueGrey[100];

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: lightcolor,
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              // height: 30,
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.info_circle,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Now supports العربية, Türkçe, English, Українська, and Español languages.',
                    style: GoogleFonts.roboto(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                color: Colors.blueGrey[300],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total New Assets Saudi Arabia',
                            style: GoogleFonts.roboto(
                                color: darkest,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      Text(
                        'Location: Saudi Arabia',
                        style: GoogleFonts.roboto(
                          color: Colors.blueGrey[900],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Card(
                        child: Container(
                          width: 170,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                              color: mediumDark,
                              borderRadius: BorderRadius.circular(4)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      color:
                                          const Color.fromARGB(255, 61, 68, 71),
                                      height: 35,
                                      width: 35,
                                      child: const Icon(
                                        Icons.laptop,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    laptopCount.toString(),
                                    style: GoogleFonts.roboto(
                                        color: const Color.fromARGB(
                                            255, 61, 68, 71),
                                        fontSize: 42,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                'Laptops',
                                style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 61, 68, 71),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: 170,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 176, 197, 179),
                              borderRadius: BorderRadius.circular(4)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      color:
                                          const Color.fromARGB(255, 65, 77, 67),
                                      height: 35,
                                      width: 35,
                                      child: const Icon(
                                        Icons.tab,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    iPadcount.toString(),
                                    style: GoogleFonts.roboto(
                                        color: const Color.fromARGB(
                                            255, 65, 77, 67),
                                        fontSize: 42,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                'iPads',
                                style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 65, 77, 67),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: 170,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 197, 197, 176),
                              borderRadius: BorderRadius.circular(4)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      color:
                                          const Color.fromARGB(255, 80, 80, 67),
                                      height: 35,
                                      width: 35,
                                      child: const Icon(
                                        Icons.keyboard,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    mouseKeyboardCount.toString(),
                                    style: GoogleFonts.roboto(
                                        color: const Color.fromARGB(
                                            255, 80, 80, 67),
                                        fontSize: 42,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                'Mouse & Keyboard',
                                style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 80, 80, 67),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: 170,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 196, 176, 197),
                              borderRadius: BorderRadius.circular(4)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      color:
                                          const Color.fromARGB(255, 87, 74, 74),
                                      height: 35,
                                      width: 35,
                                      child: const Icon(
                                        Icons.headphones,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    headPhone.toString(),
                                    style: GoogleFonts.roboto(
                                        color: const Color.fromARGB(
                                            255, 87, 74, 74),
                                        fontSize: 42,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                'Head Phones',
                                style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 87, 74, 74),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: 170,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 197, 176, 183),
                              borderRadius: BorderRadius.circular(4)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      color:
                                          const Color.fromARGB(255, 87, 74, 74),
                                      height: 35,
                                      width: 35,
                                      child: const Icon(
                                        Icons.monitor,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '0',
                                    style: GoogleFonts.roboto(
                                        color: const Color.fromARGB(
                                            255, 87, 74, 74),
                                        fontSize: 42,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                'Monitors',
                                style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 87, 74, 74),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: 170,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 176, 177, 197),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      color:
                                          const Color.fromARGB(255, 74, 87, 85),
                                      height: 35,
                                      width: 35,
                                      child: const Icon(
                                        Icons.dock,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '0',
                                    style: GoogleFonts.roboto(
                                        color: const Color.fromARGB(
                                            255, 87, 74, 74),
                                        fontSize: 42,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                'DockStation',
                                style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 87, 74, 74),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 01,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4)),
                color: Colors.blueGrey[300],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Other Assets',
                            style: GoogleFonts.roboto(
                                color: darkest,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 125,
                        width: 220,
                        child: Card(
                          color: mediumDark,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Switches',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '0',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Access Points',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '3',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Routers',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '0',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Firewalls',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '0',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 125,
                        width: 220,
                        child: Card(
                          color: mediumDark,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'TV',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '0',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'VC Device',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '0',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Meeting Room Cam',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '0',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Webcam',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '0',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 125,
                        width: 220,
                        child: Card(
                          color: mediumDark,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'CCTV NVR',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '0',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'USB Drive',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '0',
                                      style: GoogleFonts.roboto(
                                          color: darkest,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.blueGrey[300],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tech Refresh 2024 ',
                    style: GoogleFonts.roboto(
                        color: dark2,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Location: Saudi Arabia',
                    style: GoogleFonts.roboto(
                      color: dark2,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: mediumDark,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                color: dark2,
                                height: 35,
                                width: 35,
                                child: const Icon(
                                  Icons.laptop,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    'Mohamed Ibrahim',
                                    style: GoogleFonts.roboto(
                                        color: darkest,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  'Saudi Arabia',
                                  style: GoogleFonts.roboto(
                                      color: dark2,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Scheduled Date',
                                  style: GoogleFonts.roboto(
                                      color: dark2,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '01-Sep-2024',
                                  style: GoogleFonts.roboto(
                                      color: darkest,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Current Asset',
                                  style: GoogleFonts.roboto(
                                      color: dark2,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Lenovo X13',
                                  style: GoogleFonts.roboto(
                                      color: darkest,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Assigned Date',
                                  style: GoogleFonts.roboto(
                                      color: dark2,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '28-Jul-2020',
                                  style: GoogleFonts.roboto(
                                      color: darkest,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: mediumDark,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                color: dark2,
                                height: 35,
                                width: 35,
                                child: const Icon(
                                  Icons.laptop,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    'Shady Sakr',
                                    style: GoogleFonts.roboto(
                                        color: darkest,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  'Saudi Arabia',
                                  style: GoogleFonts.roboto(
                                      color: dark2,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Scheduled Date',
                                  style: GoogleFonts.roboto(
                                      color: dark2,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '21-Sep-2024',
                                  style: GoogleFonts.roboto(
                                      color: darkest,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Current Asset',
                                  style: GoogleFonts.roboto(
                                      color: dark2,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Lenovo',
                                  style: GoogleFonts.roboto(
                                      color: darkest,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Assigned Date',
                                  style: GoogleFonts.roboto(
                                      color: dark2,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '12-Dec-2020',
                                  style: GoogleFonts.roboto(
                                      color: darkest,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
