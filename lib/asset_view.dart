import 'package:asset_tracker/components/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AssetView extends StatefulWidget {
  final dynamic assetReceived;

  const AssetView({Key? key, required this.assetReceived}) : super(key: key);

  @override
  State<AssetView> createState() => _AssetViewState();
}

class _AssetViewState extends State<AssetView> {
  int? _hoveredAction;

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Iconsax.warning_2, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text('Could not launch URL', style: GoogleFonts.inter()),
              ],
            ),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      }
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Iconsax.tick_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Text('Copied to clipboard',
                style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
          ],
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  IconData _getAssetIcon(String assetType) {
    switch (assetType) {
      case 'Laptop':
        return Icons.monitor;
      case 'Mouse & Keyboard':
        return Iconsax.keyboard;
      case 'HeadPhone':
        return Iconsax.headphone;
      case 'iPad':
        return Icons.tab;
      default:
        return Iconsax.setting_2;
    }
  }

  Color _getAssetColor(String assetType) {
    switch (assetType) {
      case 'Laptop':
        return const Color(0xFF0EA5E9);
      case 'Mouse & Keyboard':
        return const Color(0xFF06B6D4);
      case 'HeadPhone':
        return const Color(0xFFEC4899);
      case 'iPad':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF64748B);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          CommonWidgets.TopBar('Asset Details'),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildDeviceDetailsCard()),
                            const SizedBox(width: 20),
                            Expanded(child: _buildOtherDetailsCard()),
                          ],
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
          _buildSidebarAction(Iconsax.printer, 'Print', 1, () {
            // Print functionality
          }),
          _buildSidebarAction(Iconsax.edit_2, 'Edit', 2, () {
            // Edit functionality
          }),
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
          onTap: onTap,
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

  Widget _buildHeader() {
    final assetColor = _getAssetColor(widget.assetReceived.assetType ?? '');

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [assetColor.withOpacity(0.1), assetColor.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: assetColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: assetColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: assetColor.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              _getAssetIcon(widget.assetReceived.assetType ?? ''),
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.assetReceived.assetType ?? 'Asset',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'SN: ',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.assetReceived.sn ?? 'N/A',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF0F172A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () =>
                          _copyToClipboard(widget.assetReceived.sn ?? ''),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: const Icon(
                          Iconsax.copy,
                          size: 14,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildStatusBadge(),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    final status = widget.assetReceived.status ?? 'Unknown';
    Color badgeColor;

    switch (status.toLowerCase()) {
      case 'active':
      case 'assigned':
        badgeColor = const Color(0xFF10B981);
        break;
      case 'available':
        badgeColor = const Color(0xFF0EA5E9);
        break;
      case 'maintenance':
        badgeColor = const Color(0xFFF59E0B);
        break;
      case 'retired':
        badgeColor = const Color(0xFF64748B);
        break;
      default:
        badgeColor = const Color(0xFF94A3B8);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: badgeColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: badgeColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            status,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: badgeColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0EA5E9).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Iconsax.mobile,
                  color: Color(0xFF0EA5E9),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Device Specifications',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFFE2E8F0)),
          const SizedBox(height: 20),
          _buildDetailRow('IMEI Number', widget.assetReceived.imeiNumber),
          _buildDetailRow('Device Model', widget.assetReceived.deviceModel),
          _buildDetailRow('Processor', widget.assetReceived.processor),
          _buildDetailRow('RAM', widget.assetReceived.ram),
          _buildDetailRow('Hard Drive', widget.assetReceived.hardDrive),
          _buildDetailRow('Display Size', widget.assetReceived.displaySize),
          const SizedBox(height: 24),
          _buildWarrantySection(),
        ],
      ),
    );
  }

  Widget _buildOtherDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Iconsax.information,
                  color: Color(0xFF8B5CF6),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Asset Information',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFFE2E8F0)),
          const SizedBox(height: 20),
          _buildDetailRow('Sub Status', widget.assetReceived.substatus),
          _buildDetailRow('Assigned To', widget.assetReceived.assignee),
          _buildDetailRow(
            'Assigned Date',
            widget.assetReceived.assignedDate != null
                ? DateFormat('dd-MMM-yyyy')
                    .format(widget.assetReceived.assignedDate)
                : null,
          ),
          const SizedBox(height: 16),
          _buildSectionDivider('Location Details'),
          const SizedBox(height: 16),
          _buildDetailRow('Local IT Site', widget.assetReceived.localITSite),
          _buildDetailRow('Location', widget.assetReceived.location),
          _buildDetailRow('Legal Entity', widget.assetReceived.legalentity),
          const SizedBox(height: 16),
          _buildSectionDivider('Purchase Information'),
          const SizedBox(height: 16),
          _buildDetailRow('Supplier', widget.assetReceived.supplier),
          _buildDetailRow(
            'Purchased Date',
            widget.assetReceived.purchasedDate != null
                ? DateFormat('dd-MMM-yyyy')
                    .format(widget.assetReceived.purchasedDate)
                : null,
          ),
          _buildDetailRow(
            'Created Date',
            widget.assetReceived.createdDate != null
                ? DateFormat('dd-MMM-yyyy')
                    .format(widget.assetReceived.createdDate)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value != null && value.isNotEmpty ? value : 'N/A',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF0F172A),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionDivider(String title) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFE2E8F0),
                  const Color(0xFFE2E8F0).withOpacity(0),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFE2E8F0).withOpacity(0),
                  const Color(0xFFE2E8F0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWarrantySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Iconsax.shield_tick,
                  color: Color(0xFF10B981), size: 16),
              const SizedBox(width: 8),
              Text(
                'Warranty Information',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (widget.assetReceived.assetType == 'Laptop')
            _buildWarrantyButton(
              'Check Lenovo Warranty',
              'https://pcsupport.lenovo.com/us/en',
              Iconsax.monitor_mobbile,
            )
          else if (widget.assetReceived.assetType == 'iPad')
            _buildWarrantyButton(
              'Check Apple Warranty',
              'https://checkcoverage.apple.com/?locale=en_SA',
              Icons.apple,
            )
          else
            Text(
              'No warranty check available for this device type',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: const Color(0xFF64748B),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWarrantyButton(String label, String url, IconData icon) {
    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF0EA5E9).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF0EA5E9).withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF0EA5E9), size: 16),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0EA5E9),
              ),
            ),
            const Spacer(),
            const Icon(
              Iconsax.arrow_right_3,
              color: Color(0xFF0EA5E9),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
