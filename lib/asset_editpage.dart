import 'package:asset_tracker/components/btext_field.dart';
import 'package:asset_tracker/components/common_widgets.dart';
import 'package:asset_tracker/components/onscreen_button.dart';
import 'package:asset_tracker/data_class/data_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AssetEditPage extends StatefulWidget {
  final dynamic singleAsset;
  final List statuses;
  final List subStatuses;

  const AssetEditPage(
      {required this.singleAsset,
      required this.statuses,
      required this.subStatuses,
      super.key});

  @override
  State<AssetEditPage> createState() => _AssetEditPageState();
}

class _AssetEditPageState extends State<AssetEditPage> {
  final assetLitItems = AssetsListItems();

  late String status3;

  @override
  void initState() {
    super.initState();

    selectedStatus = widget.singleAsset.status.toString();
    selectedSubStatus = widget.singleAsset.substatus.toString();

    //location = widget.singleAsset.location.toString();
    // localITSite = widget.singleAsset.loaclITSite;
    if (widget.singleAsset.purchasedDate != null) {
      purchaseDateController.text =
          DateFormat('dd-MMM-yyyy').format(widget.singleAsset.purchasedDate!);
    }

    legalEntity1 = legalEntityList[0];
    selectedBrand = brand[0];
    supplier = supplierList[0];
    status3 = widget.singleAsset.status.toString();
    sncontroller.text = widget.singleAsset.sn.toString();
    imeicontroller.text = widget.singleAsset.imeiNumber.toString();
    deviceModleController.text = widget.singleAsset.deviceModel.toString();
    deviceNameController.text = widget.singleAsset.assetname.toString();
    processorContorller.text = widget.singleAsset.processor.toString();
    ramController.text = widget.singleAsset.ram.toString();
    harddriveController.text = widget.singleAsset.hardDrive.toString();
    displaySizeController.text = widget.singleAsset.displaySize.toString();
    warrantYearsController.text = widget.singleAsset.warrantyPeriod.toString();
    notescontroller.text = widget.singleAsset.notes.toString();
    supprotPeriodcontroller.text = widget.singleAsset.supportPeriod.toString();
    sapNumbercontroller.text = widget.singleAsset.sapnumber.toString();
    invNumbercontroller.text = widget.singleAsset.invNumber.toString();
    assetnumbercontroller.text = widget.singleAsset.assetNumber.toString();
    localITSiteController.text = widget.singleAsset.localITSite.toString();
    if (widget.singleAsset.assignedDate != null) {
      assigneDateController.text =
          DateFormat('dd-MMM-yyyy').format(widget.singleAsset.assignedDate!);
    }
  }

  final _assigneeFilterController = TextEditingController();
  final _filterController = TextEditingController();

  bool isLoading = true; // Track loading state
  String? errorMessage; // Track error message

  List _statuses = []; // List to hold unique statuses

  List _substatus = [];
  List<dynamic> _allAssets = []; // Replace `dynamic` with your asset model type
  List<dynamic> _filteredAssets = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate1 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate1 != null) {
      setState(() {
        purchaseDateController.text =
            DateFormat("dd-MMM-yyyy").format(pickedDate1);
        purchasedDate1 = pickedDate1;
        debugPrint("Selected Date: $purchasedDate1"); // Debug output
      });
    } else {
      debugPrint("No date selected.");
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

  List<String> assigneeList = ['Ismail Ibrahim', 'Steve Jobs'];
  List<String> localITSitelist = ['META Region'];
  List<String> locationList = ['Saudi Arabia', 'UAE'];
  List<String> legalEntityList = ['Acino'];
  List<String> supplierList = ['Technology Triangle'];

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

  String? selectedAssetType;
  String? selectedStatus;
  String? selectedSubStatus;
  String? selectedBrand;
  String? localITSite;
  String? location1;
  String? legalEntity1 = '';
  String? supplier;
  String assignee = '';

  //error texts
  String? asseterrorText;
  String? branderrorText;
  String? errorText;
  String? deviceModelerrorText;

  TextEditingController dateController = TextEditingController();
  TextEditingController assignedateController = TextEditingController();

  DateTime? purchasedDate1;
  DateTime? assignedDate1;

  List<String> assetstype = [
    'Laptop',
    'iPad',
    'Mouse & Keyboard',
    'Mouse',
    'Keyboard',
    'HeadPhone'
        'Other'
  ];

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

  var assetListitems = AssetsListItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CommonWidgets.TopBar('Assets'),
          Expanded(
            child: Row(
              children: [
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
                              Icons.save,
                              'Save',
                              0,
                              () {
                                assetListitems
                                    .updateProduct(widget.singleAsset.id, {
                                  'assetNumber': assetnumbercontroller.text,
                                  'invNumber': invNumbercontroller.text,
                                  'notes': notescontroller.text,
                                  'sapnumber': sapNumbercontroller.text,
                                  'supportPeriod': supprotPeriodcontroller.text,
                                  // 'assetType': selectedAssetType!,
                                  // 'brand': selectedBrand!,
                                  'sn': sncontroller.text,
                                  'imeiNumber': imeicontroller.text,
                                  'deviceModel': deviceModleController.text,
                                  'assetname': deviceNameController.text,
                                  'processor': processorContorller.text,
                                  'ram': ramController.text,
                                  'hardDrive': harddriveController.text,
                                  'displaySize': displaySizeController.text,

                                  'purchasedate': purchasedDate1 ??
                                      widget.singleAsset.purchasedDate,

                                  'warrantyPeriod': warrantYearsController.text,
                                  // 'assignee': assigneeController.text,
                                  // 'status': selectedStatus!,
                                  // 'substatus': selectedSubStatus!,
                                  // 'assignedDate': assignedDate1,
                                  // 'localITSite': localITSite!,
                                  // 'location': location!,
                                  // 'legalentity': legalEntity1,
                                  // 'supplier': supplier!,
                                  // 'createdDate': DateTime.now()
                                });

                                Navigator.pop(context);
                              },
                            ),
                            // _buildMenuItem(
                            //   Icons.edit,
                            //   'Edit',
                            //   0,
                            //   () {},
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xffE2E2E2),
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SingleChildScrollView(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        child: Row(
                                      children: [
                                        SizedBox(
                                          width: 380,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Asset Type'),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3,
                                                            horizontal: 5),
                                                    height: 28,
                                                    width: 240,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                          width: 0.6,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2)),
                                                    child:
                                                        DropdownButton<String>(
                                                      isExpanded: true,
                                                      underline: SizedBox(),
                                                      value: selectedAssetType,
                                                      hint: Text('Asset Type'),
                                                      items: assetstype
                                                          .map((item) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: item,
                                                          child: Text(item),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedAssetType =
                                                              value;
                                                          asseterrorText = null;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (asseterrorText != null)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    asseterrorText!,
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Brand'),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 3,
                                                            horizontal: 5),
                                                    height: 28,
                                                    width: 240,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            width: 0.6),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2)),
                                                    child:
                                                        DropdownButton<String>(
                                                      isExpanded: true,
                                                      underline: SizedBox(),
                                                      value: selectedBrand,
                                                      hint:
                                                          Text('Select Brand'),
                                                      items: brand.map((item) {
                                                        return DropdownMenuItem<
                                                            String>(
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
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    branderrorText!,
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.red),
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
                                                    if (j.isNotEmpty &&
                                                        errorText != null) {
                                                      setState(() {
                                                        errorText = null;
                                                        // Clear the error message
                                                      });
                                                    }
                                                  }),
                                              if (errorText != null)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        errorText!,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                color:
                                                                    Colors.red),
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
                                                  controller:
                                                      deviceModleController,
                                                  label: 'Device Model',
                                                  onChanged: (j) {}),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              BTextField(
                                                  controller:
                                                      deviceNameController,
                                                  label: 'Device Name',
                                                  onChanged: (j) {}),
                                              SizedBox(
                                                height: 25,
                                              ),
                                              BTextField(
                                                  controller:
                                                      processorContorller,
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
                                                  controller:
                                                      harddriveController,
                                                  label: 'Hard Drive',
                                                  onChanged: (j) {}),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              BTextField(
                                                  controller:
                                                      displaySizeController,
                                                  label: 'Display Size',
                                                  onChanged: (j) {}),
                                              SizedBox(
                                                height: 25,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Purchased Date'),
                                                  SizedBox(
                                                    height: 30,
                                                    width: 240,
                                                    child: TextField(
                                                      controller:
                                                          purchaseDateController,
                                                      readOnly:
                                                          true, // Prevent manual editing
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Select Purchased Date',
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        3),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2)),
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
                                                  controller:
                                                      warrantYearsController,
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
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                        ),
                                        SizedBox(
                                          width: 380,
                                          child: SizedBox(
                                              width: 380,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Assigned to'),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 28,
                                                            width: 208,
                                                            child:
                                                                TypeAheadField<
                                                                    String>(
                                                              textFieldConfiguration:
                                                                  TextFieldConfiguration(
                                                                controller:
                                                                    assigneeController,
                                                                decoration:
                                                                    InputDecoration(
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              5,
                                                                          vertical:
                                                                              3),
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  filled: true,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(3),
                                                                    borderSide:
                                                                        BorderSide(
                                                                            width:
                                                                                0.5),
                                                                  ),
                                                                ),
                                                              ),
                                                              suggestionsCallback:
                                                                  (pattern) {
                                                                return assigneeList.where((item) => item
                                                                    .toLowerCase()
                                                                    .contains(
                                                                        pattern
                                                                            .toLowerCase()));
                                                              },
                                                              itemBuilder:
                                                                  (context,
                                                                      suggestion) {
                                                                return ListTile(
                                                                  title: Text(
                                                                      suggestion),
                                                                );
                                                              },
                                                              onSuggestionSelected:
                                                                  (suggestion) {
                                                                setState(() {
                                                                  assigneeController
                                                                          .text =
                                                                      suggestion; // Set selected text
                                                                  assignee =
                                                                      suggestion;
                                                                  selectedStatus =
                                                                      status[
                                                                          2]; // Update the status
                                                                  selectedSubStatus =
                                                                      subStatus[
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
                                                                assignee =
                                                                    ''; // Reset assignee
                                                                selectedStatus =
                                                                    null; // Reset status
                                                                selectedSubStatus =
                                                                    null; // Reset sub-status
                                                              });
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                                color: Colors
                                                                    .blue
                                                                    .withOpacity(
                                                                        0.8),
                                                              ),
                                                              width: 28,
                                                              height: 28,
                                                              child: Icon(
                                                                Icons
                                                                    .remove_circle_outline_sharp,
                                                                color: Colors
                                                                    .white,
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Status'),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 3,
                                                                horizontal: 5),
                                                        height: 28,
                                                        width: 240,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                width: 0.6),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2)),
                                                        child: DropdownButton<
                                                            String>(
                                                          isExpanded: true,
                                                          underline: SizedBox(),
                                                          value: selectedStatus,
                                                          hint: Text('Status'),
                                                          items: _statuses
                                                              .map((item) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: item,
                                                              child: Text(item),
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectedStatus =
                                                                  value;
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('sub Status'),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 3,
                                                                horizontal: 5),
                                                        height: 28,
                                                        width: 240,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                width: 0.6),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2)),
                                                        child: DropdownButton<
                                                            String>(
                                                          isExpanded: true,
                                                          underline: SizedBox(),
                                                          value:
                                                              selectedSubStatus,
                                                          hint: Text(
                                                              'Sub Status'),
                                                          items: _substatus
                                                              .map((item) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: item,
                                                              child: Text(item),
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectedSubStatus =
                                                                  value;
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Assigned Date'),
                                                      SizedBox(
                                                        height: 30,
                                                        width: 240,
                                                        child: TextField(
                                                          controller:
                                                              assigneDateController,
                                                          readOnly:
                                                              true, // Prevent manual editing
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'Select Assigned Date',
                                                            fillColor:
                                                                Colors.white,
                                                            filled: true,
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            5,
                                                                        vertical:
                                                                            3),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2)),
                                                            suffixIcon: Icon(Icons
                                                                .calendar_today), // Add calendar icon
                                                          ),
                                                          onTap: () =>
                                                              _selectAssignedDate(
                                                                  context), // Open date picker on tap
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Local IT Site'),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 3,
                                                                horizontal: 5),
                                                        height: 28,
                                                        width: 240,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                width: 0.6),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2)),
                                                        child: DropdownButton<
                                                            String>(
                                                          isExpanded: true,
                                                          underline: SizedBox(),
                                                          value: localITSite,
                                                          hint: Text(
                                                              'Sub Status'),
                                                          items: localITSitelist
                                                              .map((item) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: item,
                                                              child: Text(item),
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              localITSite =
                                                                  value;
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Location'),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 3,
                                                                horizontal: 5),
                                                        height: 28,
                                                        width: 240,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                width: 0.6),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2)),
                                                        child: DropdownButton<
                                                            String>(
                                                          isExpanded: true,
                                                          underline: SizedBox(),
                                                          value: location1,
                                                          hint:
                                                              Text('Location'),
                                                          items: locationList
                                                              .map((item) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: item,
                                                              child: Text(item),
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              location1 = value;
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Legal Entity'),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 3,
                                                                horizontal: 5),
                                                        height: 28,
                                                        width: 240,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              width: 0.6),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2),
                                                        ),
                                                        child: DropdownButton<
                                                            String>(
                                                          isExpanded: true,
                                                          underline: SizedBox(),
                                                          value:
                                                              legalEntity1, // This should match one of the items in legalEntityList
                                                          hint: Text(
                                                              'Legal Entity'),
                                                          items: legalEntityList
                                                              .map((item) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: item,
                                                              child: Text(item),
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              legalEntity1 =
                                                                  value;
                                                            });
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Supplier'),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 3,
                                                                horizontal: 5),
                                                        height: 28,
                                                        width: 240,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                width: 0.6),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2)),
                                                        child: DropdownButton<
                                                            String>(
                                                          isExpanded: true,
                                                          underline: SizedBox(),
                                                          value: supplier,
                                                          hint:
                                                              Text('Supplier'),
                                                          items: supplierList
                                                              .map((item) {
                                                            return DropdownMenuItem<
                                                                String>(
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
                                                      controller:
                                                          supprotPeriodcontroller,
                                                      label: 'Support period',
                                                      onChanged: (j) {}),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  BTextField(
                                                      controller:
                                                          sapNumbercontroller,
                                                      label: 'SAP Number',
                                                      onChanged: (j) {}),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  BTextField(
                                                      controller:
                                                          invNumbercontroller,
                                                      label: 'INV Number',
                                                      onChanged: (j) {}),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  BTextField(
                                                      controller:
                                                          assetnumbercontroller,
                                                      label: 'Asset Number',
                                                      onChanged: (j) {}),
                                                ],
                                              )),
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                  assetListitems
                                      .updateProduct(widget.singleAsset.id, {
                                    'assetNumber': assetnumbercontroller.text,
                                    'invNumber': invNumbercontroller.text,
                                    'notes': notescontroller.text,
                                    'sapnumber': sapNumbercontroller.text,
                                    'supportPeriod':
                                        supprotPeriodcontroller.text,
                                    // 'assetType': selectedAssetType!,
                                    // 'brand': selectedBrand!,
                                    'sn': sncontroller.text,
                                    'imeiNumber': imeicontroller.text,
                                    'deviceModel': deviceModleController.text,
                                    'assetname': deviceNameController.text,
                                    'processor': processorContorller.text,
                                    'ram': ramController.text,
                                    'hardDrive': harddriveController.text,
                                    'displaySize': displaySizeController.text,

                                    'purchasedate': purchasedDate1 ??
                                        widget.singleAsset.purchasedDate,

                                    'warrantyPeriod':
                                        warrantYearsController.text,
                                    // 'assignee': assigneeController.text,
                                    'status': selectedStatus!,
                                    'substatus': selectedSubStatus!,
                                    // 'assignedDate': assignedDate1,
                                    // 'localITSite': localITSite!,
                                    // 'location': location!,
                                    // 'legalentity': legalEntity1,
                                    // 'supplier': supplier!,
                                    // 'createdDate': DateTime.now()
                                  });

                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      )
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
