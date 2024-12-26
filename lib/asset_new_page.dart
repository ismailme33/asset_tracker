import 'package:asset_tracker/components/btext_field.dart';
import 'package:asset_tracker/components/common_widgets.dart';
import 'package:asset_tracker/components/onscreen_button.dart';
import 'package:asset_tracker/data_class/assets_model.dart';
import 'package:asset_tracker/data_class/data_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AssetnewPage extends StatefulWidget {
  const AssetnewPage({super.key});

  @override
  State<AssetnewPage> createState() => _AssetViewPageState();
}

class _AssetViewPageState extends State<AssetnewPage> {
  @override
  void initState() {
    super.initState();

    location = locationList[0];
    localITSite = localITSitelist[0];
    legalEntity = legalEntityList[0];
    selectedBrand = brand[0];
    supplier = supplierList[0];
  }

  int _selectedTabIndex = 0;

  String? selectedAssetType;
  String? selectedStatus;
  String? selectedSubStatus;
  String? selectedBrand;
  String? localITSite;
  String? location;
  String legalEntity = '';
  String? supplier;
  String assignee = '';

  //error texts
  String? asseterrorText;
  String? branderrorText;
  String? errorText;
  String? deviceModelerrorText;

  DateTime? purchasedDate;
  TextEditingController dateController = TextEditingController();
  TextEditingController assignedateController = TextEditingController();

  DateTime? purchasedDate1;
  DateTime? assignedDate1;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate1 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate1 != null) {
      // Format and display the date in the TextField
      setState(() {
        purchaseDateController.text =
            DateFormat("dd-MMM-yyyy").format(pickedDate1);
        purchasedDate1 = pickedDate1;
      });
    }
  }

  Future<void> _selectAssignedDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      // Format and display the date in the TextField
      setState(() {
        assigneDateController.text =
            DateFormat("dd-MMM-yyyy").format(pickedDate);
        assignedDate1 = pickedDate;
      });
    }
  }

  List<String> assetstype = [
    'Laptop',
    'iPad',
    'Mouse & Keyboard',
    'Mouse',
    'Keyboard',
    'HeadPhone',
    'Other'
  ];

  List<String> assigneeList = ['Ismail Ibrahim', 'Steve Jobs'];
  List<String> localITSitelist = ['META Region'];
  List<String> locationList = ['Saudi Arabia', 'UAE'];
  List<String> legalEntityList = ['Acino'];

  List<String> supplierList = ['Technology Triangle'];

  List<String> status = [
    'Used',
    'New',
    'Assigned',
    'Recycled',
    'Non Usable',
    'Damaged',
    'Repair'
  ];

  List<String> subStatus = [
    'Available',
    'New',
    'Ready',
    'Assigned',
    'Under Repair',
    'Available in Store',
  ];

  List<String> brand = [
    'Lenovo',
    'Apple',
    'HP',
    'Cisco',
    'Jabra',
    'Other',
  ];

  final sncontroller = TextEditingController();
  final imeicontroller = TextEditingController();
  final deviceModleController = TextEditingController();
  final deviceNameController = TextEditingController();
  final processorContorller = TextEditingController();
  final ramController = TextEditingController();
  final harddriveController = TextEditingController();
  final displaySizeController = TextEditingController();
  final purchaseDateController = TextEditingController();
  final warrantYearsController = TextEditingController();
  final assigneeController = TextEditingController();
  final statusController = TextEditingController();
  final subStatusController = TextEditingController();
  var assigneDateController = TextEditingController();
  final localITSiteController = TextEditingController();
  final locationcontroller = TextEditingController();
  final suppliercontroller = TextEditingController();
  final notescontroller = TextEditingController();
  final sapNumbercontroller = TextEditingController();
  final invNumbercontroller = TextEditingController();
  final assetnumbercontroller = TextEditingController();
  final supprotPeriodcontroller = TextEditingController();

  @override
  void dispose() {
    sncontroller.dispose();
    imeicontroller.dispose();
    deviceModleController.dispose();
    deviceNameController.dispose();
    processorContorller.dispose();
    ramController.dispose();
    harddriveController.dispose();
    displaySizeController.dispose();
    purchaseDateController.dispose();
    warrantYearsController.dispose();
    assigneeController.dispose();
    statusController.dispose();
    subStatusController.dispose();
    assigneDateController.dispose();
    localITSiteController.dispose();
    locationcontroller.dispose();
    suppliercontroller.dispose();
    super.dispose();
  }

  // To track the selected tab index

  @override
  Widget build(BuildContext context) {
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
                    ],
                  ),
                ),
                // Right-side content with tabs
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Custom Tab Bar
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            children: [
                              _buildTab(0, "Device Information"),
                              _buildTab(1, "Device Other Info"),
                            ],
                          ),
                        ),
                        // Tab Content
                        Expanded(
                          child: _buildTabContent(),
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          color: Colors.grey,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                OnscreenButton(
                                    width: 130,
                                    label: 'Save',
                                    onPressed: () {
                                      setState(() {
                                        if (selectedAssetType == null) {
                                          asseterrorText = 'Asset is Required';
                                        }
                                        if (selectedBrand == null) {
                                          branderrorText = 'Brand is Required';
                                        }
                                        if (sncontroller.text == '') {
                                          errorText = 'This is required';
                                        }
                                      });

                                      AssetsListItems assetsListItems =
                                          AssetsListItems();
                                      assetsListItems.uploadProducts(
                                          AssetsModel(
                                              id: Uuid.NAMESPACE_DNS,
                                              assetNumber:
                                                  assetnumbercontroller.text,
                                              invNumber:
                                                  invNumbercontroller.text,
                                              notes: notescontroller.text,
                                              sapnumber:
                                                  sapNumbercontroller.text,
                                              supportPeriod:
                                                  supprotPeriodcontroller.text,
                                              assetType: selectedAssetType!,
                                              brand: selectedBrand!,
                                              sn: sncontroller.text,
                                              imeiNumber: imeicontroller.text,
                                              deviceModel:
                                                  deviceModleController.text,
                                              assetname:
                                                  deviceNameController.text,
                                              processor:
                                                  processorContorller.text,
                                              ram: ramController.text,
                                              hardDrive:
                                                  harddriveController.text,
                                              displaySize:
                                                  displaySizeController.text,
                                              purchasedDate: purchasedDate1,
                                              warrantyPeriod:
                                                  warrantYearsController.text,
                                              assignee: assigneeController.text,
                                              status: selectedStatus!,
                                              substatus: selectedSubStatus!,
                                              assignedDate: assignedDate1,
                                              localITSite: localITSite!,
                                              location: location!,
                                              legalentity: legalEntity,
                                              supplier: supplier!,
                                              createdDate: DateTime.now()));

                                      Navigator.pop(context);
                                    }),
                              ],
                            ),
                          ),
                        )
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

  // Builds a single tab
  Widget _buildTab(int index, String title) {
    final bool isSelected = _selectedTabIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: Container(
          height: 30,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4), topRight: Radius.circular(4)),
            color: isSelected
                ? const Color.fromARGB(255, 49, 153, 205)
                : Colors.grey[800],
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[300],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  // Tab-specific content
  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return Expanded(
            child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color(0xffE2E2E2),
              borderRadius: BorderRadius.circular(4)),
          child: SingleChildScrollView(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 380,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Asset Type'),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  height: 28,
                                  width: 240,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        width: 0.6,
                                      ),
                                      borderRadius: BorderRadius.circular(2)),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    value: selectedAssetType,
                                    hint: Text('Asset Type'),
                                    items: assetstype.map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedAssetType = value;
                                        asseterrorText = null;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            if (asseterrorText != null)
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  asseterrorText!,
                                  style: GoogleFonts.roboto(color: Colors.red),
                                ),
                              ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Brand'),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  height: 28,
                                  width: 240,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(width: 0.6),
                                      borderRadius: BorderRadius.circular(2)),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    value: selectedBrand,
                                    hint: Text('Select Brand'),
                                    items: brand.map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedBrand = value;
                                        branderrorText = null;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            if (branderrorText != null)
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  branderrorText!,
                                  style: GoogleFonts.roboto(color: Colors.red),
                                ),
                              ),
                            SizedBox(
                              height: 5,
                            ),
                            BTextField(
                                controller: sncontroller,
                                starRequired: true,
                                label: 'Serial Number',
                                onChanged: (j) {
                                  if (j.isNotEmpty && errorText != null) {
                                    setState(() {
                                      errorText = null;
                                      // Clear the error message
                                    });
                                  }
                                }),
                            if (errorText != null)
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Text(
                                      errorText!,
                                      style:
                                          GoogleFonts.roboto(color: Colors.red),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            SizedBox(
                              height: 5,
                            ),
                            BTextField(
                                controller: imeicontroller,
                                autovalidate: true,
                                label: 'IMEI Number',
                                onChanged: (j) {}),
                            SizedBox(
                              height: 5,
                            ),
                            BTextField(
                                controller: deviceModleController,
                                label: 'Device Model',
                                onChanged: (j) {}),
                            SizedBox(
                              height: 5,
                            ),
                            BTextField(
                                controller: deviceNameController,
                                label: 'Device Name',
                                onChanged: (j) {}),
                            SizedBox(
                              height: 25,
                            ),
                            BTextField(
                                controller: processorContorller,
                                label: 'Processor',
                                onChanged: (j) {}),
                            SizedBox(
                              height: 5,
                            ),
                            BTextField(
                                controller: ramController,
                                label: 'RAM',
                                onChanged: (j) {}),
                            SizedBox(
                              height: 5,
                            ),
                            BTextField(
                                controller: harddriveController,
                                label: 'Hard Drive',
                                onChanged: (j) {}),
                            SizedBox(
                              height: 5,
                            ),
                            BTextField(
                                controller: displaySizeController,
                                label: 'Display Size',
                                onChanged: (j) {}),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Purchased Date'),
                                SizedBox(
                                  height: 30,
                                  width: 240,
                                  child: TextField(
                                    controller: purchaseDateController,
                                    readOnly: true, // Prevent manual editing
                                    decoration: InputDecoration(
                                      hintText: 'Select Purchased Date',
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      suffixIcon: Icon(Icons
                                          .calendar_today), // Add calendar icon
                                    ),
                                    onTap: () => _selectDate(
                                        context), // Open date picker on tap
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            BTextField(
                                controller: warrantYearsController,
                                label: 'Warranty Years',
                                onChanged: (j) {}),
                            SizedBox(
                              height: 5,
                            ),
                            BTextField(
                                controller: notescontroller,
                                height: 3,
                                label: 'Notes',
                                onChanged: (j) {}),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ));
      case 1:
        return Expanded(
            child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color(0xffE2E2E2),
              borderRadius: BorderRadius.circular(4)),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 380,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Assigned to'),
                              Row(
                                children: [
                                  Container(
                                    height: 28,
                                    width: 208,
                                    child: TypeAheadField<String>(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        controller: assigneeController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 3),
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            borderSide: BorderSide(width: 0.5),
                                          ),
                                        ),
                                      ),
                                      suggestionsCallback: (pattern) {
                                        return assigneeList.where((item) => item
                                            .toLowerCase()
                                            .contains(pattern.toLowerCase()));
                                      },
                                      itemBuilder: (context, suggestion) {
                                        return ListTile(
                                          title: Text(suggestion),
                                        );
                                      },
                                      onSuggestionSelected: (suggestion) {
                                        setState(() {
                                          assigneeController.text =
                                              suggestion; // Set selected text
                                          assignee = suggestion;
                                          selectedStatus =
                                              status[2]; // Update the status
                                          selectedSubStatus = subStatus[
                                              3]; // Update the sub-status
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        assigneeController
                                            .clear(); // Clear the input field
                                        assignee = ''; // Reset assignee
                                        selectedStatus = null; // Reset status
                                        selectedSubStatus =
                                            null; // Reset sub-status
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.blue.withOpacity(0.8),
                                      ),
                                      width: 28,
                                      height: 28,
                                      child: Icon(
                                        Icons.remove_circle_outline_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Status'),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 5),
                                height: 28,
                                width: 240,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.6),
                                    borderRadius: BorderRadius.circular(2)),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  value: selectedStatus,
                                  hint: Text('Status'),
                                  items: status.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedStatus = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('sub Status'),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 5),
                                height: 28,
                                width: 240,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.6),
                                    borderRadius: BorderRadius.circular(2)),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  value: selectedSubStatus,
                                  hint: Text('Sub Status'),
                                  items: subStatus.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSubStatus = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Assigned Date'),
                              SizedBox(
                                height: 30,
                                width: 240,
                                child: TextField(
                                  controller: assigneDateController,
                                  readOnly: true, // Prevent manual editing
                                  decoration: InputDecoration(
                                    hintText: 'Select Assigned Date',
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2)),
                                    suffixIcon: Icon(Icons
                                        .calendar_today), // Add calendar icon
                                  ),
                                  onTap: () => _selectAssignedDate(
                                      context), // Open date picker on tap
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Local IT Site'),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 5),
                                height: 28,
                                width: 240,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.6),
                                    borderRadius: BorderRadius.circular(2)),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  value: localITSite,
                                  hint: Text('Sub Status'),
                                  items: localITSitelist.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      localITSite = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Location'),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 5),
                                height: 28,
                                width: 240,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.6),
                                    borderRadius: BorderRadius.circular(2)),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  value: location,
                                  hint: Text('Location'),
                                  items: locationList.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      location = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Legal Entity'),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 5),
                                height: 28,
                                width: 240,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.6),
                                    borderRadius: BorderRadius.circular(2)),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  value: legalEntity,
                                  hint: Text('Legal Entity'),
                                  items: legalEntityList.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      legalEntity = legalEntity;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Supplier'),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 5),
                                height: 28,
                                width: 240,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 0.6),
                                    borderRadius: BorderRadius.circular(2)),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  value: supplier,
                                  hint: Text('Supplier'),
                                  items: supplierList.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      supplier = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          BTextField(
                              controller: supprotPeriodcontroller,
                              label: 'Support period',
                              onChanged: (j) {}),
                          SizedBox(
                            height: 25,
                          ),
                          BTextField(
                              controller: sapNumbercontroller,
                              label: 'SAP Number',
                              onChanged: (j) {}),
                          SizedBox(
                            height: 5,
                          ),
                          BTextField(
                              controller: invNumbercontroller,
                              label: 'INV Number',
                              onChanged: (j) {}),
                          SizedBox(
                            height: 5,
                          ),
                          BTextField(
                              controller: assetnumbercontroller,
                              label: 'Asset Number',
                              onChanged: (j) {}),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ));

      default:
        return Center(child: Text("Unknown Content"));
    }
  }
}

class btextField extends StatelessWidget {
  const btextField({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 12, color: Colors.grey[800]),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 30,
          width: 250,
          color: Colors.white,
          child: TextField(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.4),
                    borderRadius: BorderRadius.circular(2)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.4),
                    borderRadius: BorderRadius.circular(2))),
          ),
        ),
      ],
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
