import 'package:asset_tracker/asset_editpage.dart';
import 'package:asset_tracker/asset_new_page.dart';
import 'package:asset_tracker/asset_view.dart';
import 'package:asset_tracker/components/common_widgets.dart';
import 'package:asset_tracker/data_class/data_class.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class AssetList extends StatefulWidget {
  const AssetList({super.key});

  @override
  State<AssetList> createState() => _AssetListState();
}

class _AssetListState extends State<AssetList> {
  final TextEditingController _filterController = TextEditingController();
  final TextEditingController _assigneeFilterController =
      TextEditingController();

  AssetsListItems assetsListItems = AssetsListItems();

  bool isLoading = true;
  String? errorMessage;
  int? _selectedIndex;
  int? _hoveredAction;
  int? _hoveredRow;

  dynamic _selectedAsset;
  List<dynamic> _allAssets = [];
  List<dynamic> _filteredAssets = [];
  List _statuses = [];
  List _substatus = [];
  String? _selectedStatus;
  String? _selectedSubstatus;

  @override
  void initState() {
    super.initState();
    _fetchAssets();
    _filterController.addListener(_filterAssets);
    _assigneeFilterController.addListener(_filterAssets);
  }

  @override
  void dispose() {
    _filterController.dispose();
    _assigneeFilterController.dispose();
    super.dispose();
  }

  Future<void> _fetchAssets() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final fetchedAssets = await assetsListItems.fetchProducts();
      if (mounted) {
        setState(() {
          _selectedStatus = null;
          _selectedSubstatus = null;
          _assigneeFilterController.clear();
          _filterController.clear();
          _allAssets = fetchedAssets;
          _filteredAssets = fetchedAssets;
          isLoading = false;

          _statuses = ["All"] +
              _allAssets
                  .map((asset) => asset.status.toString())
                  .toSet()
                  .toList();
          _substatus = ["All"] +
              _allAssets
                  .map((asset) => asset.substatus.toString())
                  .toSet()
                  .toList();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
          errorMessage = 'Error fetching assets: $e';
        });
      }
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
        final matchesSubstatus = _selectedSubstatus == "All" ||
            _selectedSubstatus == null ||
            asset.substatus == _selectedSubstatus;

        return matchesSN &&
            matchesAssignee &&
            matchesSubstatus &&
            matchesStatus;
      }).toList();
      _selectedIndex = null;
      _selectedAsset = null;
    });
  }

  IconData _getAssetIcon(String? assetType) {
    switch (assetType) {
      case 'Laptop':
        return Icons.laptop;
      case 'iPad':
      case 'iPads':
        return Icons.tablet;
      case 'Mouse & Keyboard':
        return Iconsax.keyboard;
      case 'HeadPhone':
        return Iconsax.headphone;
      default:
        return Iconsax.setting_2;
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
      case 'assigned':
        return const Color(0xFF10B981);
      case 'available':
        return const Color(0xFF0EA5E9);
      case 'maintenance':
        return const Color(0xFFF59E0B);
      case 'retired':
        return const Color(0xFF64748B);
      default:
        return const Color(0xFF94A3B8);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          CommonWidgets.TopBar('Assets'),
          Expanded(
            child: Row(
              children: [
                _buildSidebar(),
                Expanded(
                  child: Column(
                    children: [
                      _buildFilterBar(),
                      Expanded(child: _buildContent()),
                    ],
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
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        children: [
          _buildSidebarAction(Iconsax.arrow_left_2, 'Back', 0, () {
            Navigator.pop(context);
          }, true),
          const SizedBox(height: 8),
          _buildDivider(),
          const SizedBox(height: 8),
          _buildSidebarAction(Iconsax.add_circle, 'New Asset', 1, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AssetnewPage()),
            );
          }, true),
          _buildSidebarAction(Iconsax.eye, 'View Asset', 2, () {
            if (_selectedAsset != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AssetView(assetReceived: _selectedAsset),
                ),
              );
            }
          }, _selectedAsset != null),
          _buildSidebarAction(Iconsax.edit_2, 'Edit Asset', 3, () {
            if (_selectedAsset != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssetEditPage(
                    statuses: _statuses,
                    subStatuses: _substatus,
                    singleAsset: _selectedAsset,
                  ),
                ),
              ).then((result) {
                if (result != null) _fetchAssets();
              });
            }
          }, _selectedAsset != null),
          const SizedBox(height: 8),
          _buildDivider(),
          const SizedBox(height: 8),
          _buildSidebarAction(Iconsax.refresh, 'Refresh', 4, () {
            _fetchAssets();
          }, true),
          _buildSidebarAction(Iconsax.document_upload, 'Import File', 5,
              () async {
            await assetsListItems.importFromExcel();
            _fetchAssets();
          }, true),
        ],
      ),
    );
  }

  Widget _buildSidebarAction(
    IconData icon,
    String label,
    int index,
    VoidCallback onTap,
    bool enabled,
  ) {
    final isHovered = _hoveredAction == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: MouseRegion(
        onEnter: enabled ? (_) => setState(() => _hoveredAction = index) : null,
        onExit: (_) => setState(() => _hoveredAction = null),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: enabled && isHovered
                  ? const Color(0xFF334155)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: enabled
                      ? const Color(0xFF94A3B8)
                      : const Color(0xFF475569),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: enabled
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF475569),
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

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          SizedBox(
            width: 240,
            child: _buildSearchField(
              controller: _filterController,
              hint: 'Search by Serial Number',
              icon: Iconsax.search_normal_1,
            ),
          ),
          SizedBox(
            width: 240,
            child: _buildSearchField(
              controller: _assigneeFilterController,
              hint: 'Search by Assignee',
              icon: Iconsax.user_search,
            ),
          ),
          SizedBox(
            width: 200,
            child: _buildDropdown(
              value: _selectedStatus ?? "All",
              items: _statuses,
              hint: 'Filter by Status',
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                  _filterAssets();
                });
              },
            ),
          ),
          SizedBox(
            width: 200,
            child: _buildDropdown(
              value: _selectedSubstatus ?? "All",
              items: _substatus,
              hint: 'Filter by Sub-Status',
              onChanged: (value) {
                setState(() {
                  _selectedSubstatus = value;
                  _filterAssets();
                });
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Text(
              '${_filteredAssets.length} Assets',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.inter(fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          fontSize: 13,
          color: const Color(0xFF94A3B8),
        ),
        prefixIcon: Icon(icon, size: 18, color: const Color(0xFF64748B)),
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
          borderSide: const BorderSide(color: Color(0xFF0EA5E9), width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List items,
    required String hint,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: value,
        underline: const SizedBox(),
        icon: const Icon(Iconsax.arrow_down_1,
            size: 16, color: Color(0xFF64748B)),
        style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF0F172A)),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0EA5E9)),
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.danger, size: 48, color: Color(0xFFEF4444)),
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFFEF4444),
              ),
            ),
          ],
        ),
      );
    }

    if (_filteredAssets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.box, size: 48, color: Color(0xFF94A3B8)),
            const SizedBox(height: 16),
            Text(
              'No assets found',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        _buildTableHeader(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: _filteredAssets.length,
            itemBuilder: (context, index) => _buildAssetRow(index),
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      child: Row(
        children: [
          _buildHeaderCell('Type', flex: 1),
          _buildHeaderCell('Brand', flex: 2),
          _buildHeaderCell('Model', flex: 2),
          _buildHeaderCell('Serial Number', flex: 2),
          _buildHeaderCell('Assigned To', flex: 3),
          _buildHeaderCell('Status', flex: 2),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String title, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF475569),
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildAssetRow(int index) {
    final asset = _filteredAssets[index];
    final isSelected = _selectedIndex == index;
    final isHovered = _hoveredRow == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hoveredRow = index),
        onExit: (_) => setState(() => _hoveredRow = null),
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = index;
              _selectedAsset = asset;
            });
          },
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF0EA5E9).withOpacity(0.1)
                  : isHovered
                      ? const Color(0xFFF8FAFC)
                      : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF0EA5E9)
                    : const Color(0xFFE2E8F0),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Icon(
                    _getAssetIcon(asset.assetType),
                    color: const Color(0xFF64748B),
                    size: 20,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    asset.brand ?? 'N/A',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    asset.assetType ?? 'N/A',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    asset.sn ?? 'N/A',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0EA5E9),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    asset.assignee ?? 'Unassigned',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF475569),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: _buildStatusBadge(asset.status, asset.substatus),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String? status, String? substatus) {
    final statusColor = _getStatusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              status ?? 'Unknown',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: statusColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
