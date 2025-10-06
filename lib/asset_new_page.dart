import 'package:asset_tracker/components/common_widgets.dart';
import 'package:asset_tracker/data_class/assets_model.dart';
import 'package:asset_tracker/data_class/data_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AssetnewPage extends StatefulWidget {
  const AssetnewPage({super.key});

  @override
  State<AssetnewPage> createState() => _AssetnewPageState();
}

class _AssetnewPageState extends State<AssetnewPage> {
  final _formKey = GlobalKey<FormState>();
  int? _hoveredAction;
  bool _isSaving = false;

  // Controllers
  final snController = TextEditingController();
  final imeiController = TextEditingController();
  final deviceModelController = TextEditingController();
  final deviceNameController = TextEditingController();
  final processorController = TextEditingController();
  final ramController = TextEditingController();
  final hardDriveController = TextEditingController();
  final displaySizeController = TextEditingController();
  final purchaseDateController = TextEditingController();
  final warrantyYearsController = TextEditingController();
  final assigneeController = TextEditingController();
  final assigneDateController = TextEditingController();
  final supplierController = TextEditingController();
  final notesController = TextEditingController();
  final sapNumberController = TextEditingController();
  final invNumberController = TextEditingController();
  final assetNumberController = TextEditingController();
  final supportPeriodController = TextEditingController();

  // Dropdown values
  String? selectedAssetType;
  String? selectedStatus;
  String? selectedSubStatus;
  String? selectedBrand;
  String? localITSite;
  String? location;
  String? legalEntity;
  String? supplier;

  // Dates
  DateTime? purchasedDate;
  DateTime? assignedDate;

  // Lists
  final List<String> assetTypes = [
    'Laptop',
    'iPad',
    'Mouse & Keyboard',
    'Mouse',
    'Keyboard',
    'HeadPhone',
    'Monitor',
    'DockStation',
    'Other'
  ];

  final List<String> brands = [
    'Lenovo',
    'Apple',
    'HP',
    'Cisco',
    'Jabra',
    'Other'
  ];
  final List<String> statuses = [
    'New',
    'Used',
    'Assigned',
    'Recycled',
    'Non Usable',
    'Damaged',
    'Repair'
  ];
  final List<String> subStatuses = [
    'Available',
    'New',
    'Ready',
    'Assigned',
    'Under Repair',
    'Available in Store'
  ];
  final List<String> assigneeList = ['Ismail Ibrahim', 'Steve Jobs'];
  final List<String> localITSiteList = ['META Region'];
  final List<String> locationList = ['Saudi Arabia', 'UAE'];
  final List<String> legalEntityList = ['Acino'];
  final List<String> supplierList = ['Technology Triangle'];

  @override
  void initState() {
    super.initState();
    location = locationList[0];
    localITSite = localITSiteList[0];
    legalEntity = legalEntityList[0];
    selectedBrand = brands[0];
    supplier = supplierList[0];
  }

  @override
  void dispose() {
    snController.dispose();
    imeiController.dispose();
    deviceModelController.dispose();
    deviceNameController.dispose();
    processorController.dispose();
    ramController.dispose();
    hardDriveController.dispose();
    displaySizeController.dispose();
    purchaseDateController.dispose();
    warrantyYearsController.dispose();
    assigneeController.dispose();
    assigneDateController.dispose();
    notesController.dispose();
    sapNumberController.dispose();
    invNumberController.dispose();
    assetNumberController.dispose();
    supportPeriodController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isPurchaseDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0EA5E9),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        if (isPurchaseDate) {
          purchaseDateController.text =
              DateFormat("dd-MMM-yyyy").format(pickedDate);
          purchasedDate = pickedDate;
        } else {
          assigneDateController.text =
              DateFormat("dd-MMM-yyyy").format(pickedDate);
          assignedDate = pickedDate;
        }
      });
    }
  }

  Future<void> _saveAsset() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Iconsax.warning_2, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Text('Please fill all required fields',
                  style: GoogleFonts.inter()),
            ],
          ),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final assetsListItems = AssetsListItems();
      await assetsListItems.uploadProducts(
        AssetsModel(
          id: const Uuid().v4(),
          assetNumber: assetNumberController.text,
          invNumber: invNumberController.text,
          notes: notesController.text,
          sapnumber: sapNumberController.text,
          supportPeriod: supportPeriodController.text,
          assetType: selectedAssetType!,
          brand: selectedBrand!,
          sn: snController.text,
          imeiNumber: imeiController.text,
          deviceModel: deviceModelController.text,
          assetname: deviceNameController.text,
          processor: processorController.text,
          ram: ramController.text,
          hardDrive: hardDriveController.text,
          displaySize: displaySizeController.text,
          purchasedDate: purchasedDate,
          warrantyPeriod: warrantyYearsController.text,
          assignee: assigneeController.text,
          status: selectedStatus ?? 'New',
          substatus: selectedSubStatus ?? 'Available',
          assignedDate: assignedDate,
          localITSite: localITSite!,
          location: location!,
          legalentity: legalEntity!,
          supplier: supplier!,
          createdDate: DateTime.now(),
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Iconsax.tick_circle, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text('Asset created successfully', style: GoogleFonts.inter()),
              ],
            ),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Iconsax.warning_2, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text('Error: $e', style: GoogleFonts.inter()),
              ],
            ),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          CommonWidgets.TopBar('New Asset'),
          Expanded(
            child: Row(
              children: [
                _buildSidebar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 24),
                        _buildForm(),
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

  Widget _buildSidebar() {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        border: Border(
          right: BorderSide(
            color: const Color(0xFF334155).withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildSidebarAction(Iconsax.arrow_left_2, 'Back', 0, () {
            Navigator.pop(context);
          }),
          const SizedBox(height: 8),
          _buildDivider(),
          const SizedBox(height: 8),
          _buildSidebarAction(
              Iconsax.document_download, 'Save Asset', 1, _saveAsset),
        ],
      ),
    );
  }

  Widget _buildSidebarAction(
      IconData icon, String label, int index, VoidCallback onTap) {
    final isHovered = _hoveredAction == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hoveredAction = index),
        onExit: (_) => setState(() => _hoveredAction = null),
        child: InkWell(
          onTap: _isSaving ? null : onTap,
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isHovered ? const Color(0xFF334155) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF94A3B8), size: 20),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF94A3B8),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF334155).withOpacity(0),
            const Color(0xFF334155).withOpacity(0.5),
            const Color(0xFF334155).withOpacity(0),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create New Asset',
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Add a new asset to your inventory',
          style: GoogleFonts.inter(
            fontSize: 15,
            color: const Color(0xFF64748B),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Device Information', Iconsax.mobile),
            const SizedBox(height: 24),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                _buildDropdownField('Asset Type', selectedAssetType, assetTypes,
                    (value) {
                  setState(() => selectedAssetType = value);
                }, isRequired: true),
                _buildDropdownField('Brand', selectedBrand, brands, (value) {
                  setState(() => selectedBrand = value);
                }, isRequired: true),
                _buildTextField('Serial Number', snController,
                    isRequired: true),
                _buildTextField('IMEI Number', imeiController),
                _buildTextField('Device Model', deviceModelController),
                _buildTextField('Device Name', deviceNameController),
                _buildTextField('Processor', processorController),
                _buildTextField('RAM', ramController),
                _buildTextField('Hard Drive', hardDriveController),
                _buildTextField('Display Size', displaySizeController),
                _buildDateField('Purchase Date', purchaseDateController, true),
                _buildTextField('Warranty (Years)', warrantyYearsController),
              ],
            ),
            const SizedBox(height: 40),
            _buildSectionTitle('Assignment & Status', Iconsax.user_tag),
            const SizedBox(height: 24),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                _buildTypeAheadField(),
                _buildDropdownField('Status', selectedStatus, statuses,
                    (value) {
                  setState(() => selectedStatus = value);
                }),
                _buildDropdownField(
                    'Sub Status', selectedSubStatus, subStatuses, (value) {
                  setState(() => selectedSubStatus = value);
                }),
                _buildDateField('Assigned Date', assigneDateController, false),
              ],
            ),
            const SizedBox(height: 40),
            _buildSectionTitle('Location & Supplier', Iconsax.location),
            const SizedBox(height: 24),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                _buildDropdownField(
                    'Local IT Site', localITSite, localITSiteList, (value) {
                  setState(() => localITSite = value);
                }),
                _buildDropdownField('Location', location, locationList,
                    (value) {
                  setState(() => location = value);
                }),
                _buildDropdownField(
                    'Legal Entity', legalEntity, legalEntityList, (value) {
                  setState(() => legalEntity = value);
                }),
                _buildDropdownField('Supplier', supplier, supplierList,
                    (value) {
                  setState(() => supplier = value);
                }),
                _buildTextField('Support Period', supportPeriodController),
                _buildTextField('SAP Number', sapNumberController),
                _buildTextField('Invoice Number', invNumberController),
                _buildTextField('Asset Number', assetNumberController),
              ],
            ),
            const SizedBox(height: 24),
            _buildTextField('Notes', notesController,
                maxLines: 4, fullWidth: true),
            const SizedBox(height: 32),
            Row(
              children: [
                _buildActionButton(
                  label: 'Cancel',
                  onPressed: () => Navigator.pop(context),
                  isPrimary: false,
                ),
                const SizedBox(width: 16),
                _buildActionButton(
                  label: _isSaving ? 'Saving...' : 'Create Asset',
                  onPressed: _isSaving ? null : _saveAsset,
                  isPrimary: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF0EA5E9).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF0EA5E9), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isRequired = false,
    int maxLines = 1,
    bool fullWidth = false,
  }) {
    return SizedBox(
      width: fullWidth ? double.infinity : 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
              if (isRequired)
                const Text(
                  ' *',
                  style: TextStyle(color: Color(0xFFEF4444), fontSize: 13),
                ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: GoogleFonts.inter(fontSize: 14),
            validator: isRequired
                ? (value) => value?.isEmpty ?? true ? 'Required field' : null
                : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Color(0xFF0EA5E9), width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFEF4444)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String? value,
    List<String> items,
    Function(String?) onChanged, {
    bool isRequired = false,
  }) {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
              if (isRequired)
                const Text(
                  ' *',
                  style: TextStyle(color: Color(0xFFEF4444), fontSize: 13),
                ),
            ],
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            validator: isRequired
                ? (value) => value == null ? 'Required field' : null
                : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Color(0xFF0EA5E9), width: 2),
              ),
            ),
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item, style: GoogleFonts.inter(fontSize: 14)),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(
      String label, TextEditingController controller, bool isPurchaseDate) {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            readOnly: true,
            style: GoogleFonts.inter(fontSize: 14),
            onTap: () => _selectDate(context, isPurchaseDate),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              suffixIcon: const Icon(Iconsax.calendar,
                  size: 18, color: Color(0xFF64748B)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Color(0xFF0EA5E9), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeAheadField() {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assigned To',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 8),
          TypeAheadField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: assigneeController,
              style: GoogleFonts.inter(fontSize: 14),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                suffixIcon: assigneeController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Iconsax.close_circle, size: 18),
                        onPressed: () {
                          setState(() {
                            assigneeController.clear();
                            selectedStatus = null;
                            selectedSubStatus = null;
                          });
                        },
                      )
                    : null,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Color(0xFF0EA5E9), width: 2),
                ),
              ),
            ),
            suggestionsCallback: (pattern) {
              return assigneeList.where(
                  (item) => item.toLowerCase().contains(pattern.toLowerCase()));
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion, style: GoogleFonts.inter(fontSize: 14)),
              );
            },
            onSuggestionSelected: (suggestion) {
              setState(() {
                assigneeController.text = suggestion;
                selectedStatus = statuses[2]; // Assigned
                selectedSubStatus = subStatuses[3]; // Assigned
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback? onPressed,
    required bool isPrimary,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? const Color(0xFF0EA5E9) : Colors.white,
        foregroundColor: isPrimary ? Colors.white : const Color(0xFF64748B),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: isPrimary
              ? BorderSide.none
              : const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        elevation: 0,
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
