import 'package:asset_tracker/asset_editpage.dart';
import 'package:asset_tracker/asset_new_page.dart';
import 'package:asset_tracker/asset_view.dart';
import 'package:asset_tracker/components/common_widgets.dart';
import 'package:asset_tracker/data_class/data_class.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _AssetListState();
}

class _AssetListState extends State<UsersList> {
  final TextEditingController _filterController = TextEditingController();
  final TextEditingController _assigneeFilterController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    _fetchAssets();
    _filterController.addListener(_filterAssets);
  }

  final assetNameController = TextEditingController();

  dynamic _selectedAsset;
  String? assetsn;

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  bool isSelected = false;

  final nameController = TextEditingController();

  int? _selectedIndex;

  AssetsListItems assetsListItems = AssetsListItems();
  bool isLoading = true; // Track loading state
  String? errorMessage; // Track error message

  List _statuses = []; // List to hold unique statuses
  String? _selectedStatus;
  String? _selectedsubstatus;
  List _substatus = [];

  Future<void> _fetchAssets() async {
    setState(() {
      isLoading = true; // Set loading state to true before fetching
      errorMessage = null; // Clear any previous error messages
    });

    try {
      final fetchedAssets = await assetsListItems.fetchProducts();
      setState(() {
        _selectedStatus = null;
        _assigneeFilterController.text = '';
        _filterController.text = '';

        _selectedsubstatus = null;
        _allAssets = fetchedAssets;
        _filteredAssets = fetchedAssets;
        isLoading = false; // Set loading state to false after fetching

        // Extract unique statuses and add "All" at the start
        _statuses = ["All"] +
            _allAssets
                .map((asset) =>
                    asset.status.toString()) // Ensure status is a String
                .toSet()
                .toList();
        _substatus = ["All"] +
            _allAssets
                .map((asset) =>
                    asset.substatus.toString()) // Ensure status is a String
                .toSet()
                .toList();
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Set loading state to false after error
        errorMessage = 'Error fetching assets: $e'; // Set error message
      });
    }
  }

  void _filterAssets() {
    final snQuery = _filterController.text.toLowerCase();
    final assigneeQuery = _assigneeFilterController.text.toLowerCase();

    setState(() {
      _filteredAssets = _allAssets.where((asset) {
        final matchesSN =
            snQuery.isEmpty || asset.sn.toLowerCase().contains(snQuery);
        final matchesAssignee = assigneeQuery.isEmpty ||
            asset.assignee.toLowerCase().contains(assigneeQuery);
        final matchesStatus = _selectedStatus == "All" ||
            _selectedStatus == null ||
            asset.status == _selectedStatus;
        final matchessubstatus = _selectedsubstatus == "All" ||
            _selectedsubstatus == null ||
            asset.substatus == _selectedsubstatus;

        return matchesSN &&
            matchesAssignee &&
            matchessubstatus &&
            matchesStatus; // All conditions must match
      }).toList();
    });
  }

  Color? darkest = Colors.blueGrey[900];
  Color? dark2 = Colors.blueGrey[600];
  Color? mediumDark = Colors.blueGrey[200];
  Color? mediumDark0 = Colors.blueGrey[200];
  Color? lightcolor = Colors.blueGrey[100];

  List<dynamic> _allAssets = []; // Replace `dynamic` with your asset model type
  List<dynamic> _filteredAssets = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          CommonWidgets.TopBar('Users'),
          Expanded(
            child: Row(
              children: [
                // Left-side menu
                Container(
                  width: 200, // Fixed width for the menu
                  color: const Color.fromARGB(255, 45, 45, 45),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // List of menu items
                      Expanded(
                        child: ListView(
                          children: [
                            _buildMenuItem(Iconsax.arrow_left, 'Back', 0, () {
                              Navigator.pop(context);
                            }, Colors.white),
                            _buildMenuItem(Iconsax.add_circle, 'New', 0, () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AssetnewPage(),
                                  ));
                            }, Colors.white),
                            _buildMenuItem(Iconsax.eye3, 'View Asset', 1, () {
                              if (_selectedAsset == null) {
                                return null;
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AssetView(
                                      assetReceived: _selectedAsset,
                                    ),
                                  ));
                            },
                                _selectedAsset == null
                                    ? Colors.grey[800]
                                    : Colors.white),
                            _buildMenuItem(Iconsax.edit, 'Edit Asset', 1, () {
                              if (_selectedAsset == null) {
                                return null;
                              }
                              final result = Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AssetEditPage(
                                      statuses: _statuses,
                                      subStatuses: _substatus,
                                      singleAsset: _selectedAsset),
                                ),
                              );
                              if (result != null) {
                                _fetchAssets();
                              }
                            },
                                _selectedAsset == null
                                    ? Colors.grey[800]
                                    : Colors.white),
                            _buildMenuItem(
                                Iconsax.refresh_circle4, 'Refresh', 5,
                                () async {
                              _fetchAssets();
                              _filterController.addListener(_filterAssets);
                            }, Colors.white),
                            _buildMenuItem(Iconsax.import, 'Import File', 5,
                                () async {
                              final assetsManager = AssetsListItems();
                              await assetsManager.importFromExcel();
                            }, Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Right-side content
                Expanded(
                    child: Container(
                  color: Colors.blueGrey[50],
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                onChanged: (value) {
                                  _selectedIndex = null;
                                },
                                controller: _filterController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: BorderSide(
                                          width: 0.5, color: Colors.blueGrey)),
                                  fillColor: Colors.blueGrey[50],
                                  filled: true,
                                  contentPadding: EdgeInsets.all(3),
                                  hintText: 'Filter by Serial Number',
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
                                controller: _assigneeFilterController,
                                onChanged: (value) {
                                  _filterAssets();
                                  _selectedIndex = null;
                                },
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      borderSide: BorderSide(
                                          width: 0.5, color: Colors.blue)),
                                  fillColor: Colors.blueGrey[50],
                                  filled: true,
                                  contentPadding: EdgeInsets.all(3),
                                  hintText: 'Assigned to',
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
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              height: 30,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[50],
                                  border: Border.all(width: 0.6),
                                  borderRadius: BorderRadius.circular(3)),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                underline: SizedBox(),
                                value: _selectedStatus ?? "All",
                                hint: Text("Filter by Status"),
                                items: _statuses.map((status) {
                                  return DropdownMenuItem<String>(
                                    value: status,
                                    child: Text(
                                      status,
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedIndex = null;
                                    _selectedStatus = newValue;
                                    _filterAssets(); // Reapply filters when status changes
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              height: 30,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[50],
                                  border: Border.all(width: 0.6),
                                  borderRadius: BorderRadius.circular(3)),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                underline: SizedBox(),
                                value: _selectedsubstatus ?? "All",
                                hint: Text("Filter by Status"),
                                items: _substatus.map((substatus1) {
                                  return DropdownMenuItem<String>(
                                    value: substatus1,
                                    child: Text(
                                      substatus1,
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedIndex = null;
                                    _selectedsubstatus = newValue;
                                    _filterAssets(); // Reapply filters when status changes
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      isLoading
                          ? Center(
                              child: Text(
                                  'Loading data ....')) // Loading indicator
                          : errorMessage != null
                              ? Center(
                                  child: Text(errorMessage!,
                                      style: TextStyle(
                                          color: Colors.red))) // Error message

                              : _filteredAssets.isEmpty
                                  ? Column(
                                      children: [
                                        Center(
                                          child: Text('No data available'),
                                        ),
                                      ],
                                    )
                                  : Expanded(
                                      child: Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey[300],
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: ListView.builder(
                                        itemCount: _filteredAssets.length,
                                        itemBuilder: (context, index) {
                                          isSelected = _selectedIndex == index;
                                          final singleAsset =
                                              _filteredAssets[index];

                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                _selectedIndex =
                                                    index; // Update the selected index
                                                _selectedAsset = singleAsset;
                                              });
                                            },
                                            child: Card(
                                              color: isSelected
                                                  ? Colors.blue.shade100
                                                  : lightcolor,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
                                                child: SizedBox(
                                                  child: Row(
                                                    children: [
                                                      if (singleAsset != null)
                                                        Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              child: Container(
                                                                color: Colors
                                                                        .blueGrey[
                                                                    600],
                                                                height: 35,
                                                                width: 35,
                                                                child: Center(
                                                                  child: Icon(
                                                                    singleAsset.assetType ==
                                                                            'Laptop'
                                                                        ? Icons
                                                                            .laptop
                                                                        : singleAsset.assetType ==
                                                                                'iPads'
                                                                            ? Icons.tab
                                                                            : singleAsset.assetType == 'Mouse & Keyboard'
                                                                                ? Icons.keyboard
                                                                                : singleAsset.assetType == 'HeadPhone'
                                                                                    ? Icons.headphones
                                                                                    : singleAsset.assetType == 'iPad'
                                                                                        ? Icons.tab
                                                                                        : Icons.settings,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                            ),
                                                            SizedBox(
                                                              width: 140,
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    singleAsset
                                                                        .brand,
                                                                    style: GoogleFonts.roboto(
                                                                        color:
                                                                            dark2,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  Text(
                                                                    singleAsset.assetType !=
                                                                            null
                                                                        ? singleAsset
                                                                            .assetType
                                                                        : 'Na',
                                                                    style: GoogleFonts.roboto(
                                                                        color:
                                                                            darkest,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      if (width >= 720)
                                                        SizedBox(
                                                          width: 160,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    'Name :  ',
                                                                    style: GoogleFonts.roboto(
                                                                        color:
                                                                            dark2,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  Text(
                                                                    singleAsset.assetname !=
                                                                            null
                                                                        ? singleAsset
                                                                            .assetname
                                                                        : Text(
                                                                            'NA'),
                                                                    style: GoogleFonts.roboto(
                                                                        color:
                                                                            darkest,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    'SN      :  ',
                                                                    style: GoogleFonts.roboto(
                                                                        color:
                                                                            dark2,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  Text(
                                                                    singleAsset.id !=
                                                                            null
                                                                        ? singleAsset
                                                                            .sn
                                                                        : 'Na',
                                                                    style: GoogleFonts.roboto(
                                                                        color:
                                                                            darkest,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      if (width >= 720)
                                                        SizedBox(
                                                          width: 280,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Assignee',
                                                                style: GoogleFonts.roboto(
                                                                    color:
                                                                        dark2,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Text(
                                                                singleAsset.assignee !=
                                                                        ''
                                                                    ? singleAsset
                                                                        .assignee
                                                                    : 'Na',
                                                                style: GoogleFonts.roboto(
                                                                    color:
                                                                        darkest,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      if (width >= 720)
                                                        SizedBox(
                                                          width: 120,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Status',
                                                                style: GoogleFonts.roboto(
                                                                    color:
                                                                        dark2,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Text(
                                                                singleAsset.status !=
                                                                        null
                                                                    ? singleAsset
                                                                        .status
                                                                    : 'Na',
                                                                style: GoogleFonts.roboto(
                                                                    color:
                                                                        darkest,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      if (width >= 720)
                                                        SizedBox(
                                                          width: 120,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Sub Status',
                                                                style: GoogleFonts.roboto(
                                                                    color:
                                                                        dark2,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Text(
                                                                singleAsset.substatus !=
                                                                        ''
                                                                    ? singleAsset
                                                                        .substatus
                                                                    : 'Na',
                                                                style: GoogleFonts.roboto(
                                                                    color:
                                                                        darkest,
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ))
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildMenuItem(
    IconData icon, String title, int index, void onClick(), Color? iconColor) {
  return InkWell(
    onTap: onClick,
    child: Container(
      padding: EdgeInsets.all(10),
      color: Colors.transparent,
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 21,
          ),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              color: iconColor,
            ),
          ),
        ],
      ),
    ),
  );
}
