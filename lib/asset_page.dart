import 'package:asset_tracker/Employees/employees_list.dart';
import 'package:asset_tracker/Invoices/invoice_create.dart';
import 'package:asset_tracker/Invoices/invoice_list.dart';
import 'package:asset_tracker/asset_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({super.key});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  int? _hoveredIndex;

  static const List<ManagementModule> _modules = [
    ManagementModule(
      icon: Iconsax.box,
      title: 'Assets',
      description: 'Manage hardware inventory',
      color: Color(0xFF0EA5E9),
      route: 'assets',
    ),
    ManagementModule(
      icon: Iconsax.people,
      title: 'Employees',
      description: 'Staff and user management',
      color: Color(0xFF8B5CF6),
      route: 'employees',
    ),
    ManagementModule(
      icon: Iconsax.receipt_text,
      title: 'Invoices',
      description: 'Financial documentation',
      color: Color(0xFF10B981),
      route: 'invoices',
    ),
    ManagementModule(
      icon: Iconsax.printer,
      title: 'Print Tracking',
      description: 'Monitor printer usage',
      color: Color(0xFFF59E0B),
      route: 'print',
    ),
    ManagementModule(
      icon: Iconsax.document_text,
      title: 'IT Forms',
      description: 'Request and approval forms',
      color: Color(0xFFEC4899),
      route: 'forms',
    ),
    ManagementModule(
      icon: Iconsax.building_4,
      title: 'Vendors & Suppliers',
      description: 'Partner management',
      color: Color(0xFF06B6D4),
      route: 'vendors',
    ),
    ManagementModule(
      icon: Iconsax.refresh,
      title: 'Tech Refresh',
      description: 'Equipment replacement cycle',
      color: Color(0xFFEF4444),
      route: 'refresh',
    ),
    ManagementModule(
      icon: Iconsax.chart_2,
      title: 'Reports',
      description: 'Analytics and insights',
      color: Color(0xFF6366F1),
      route: 'reports',
    ),
  ];

  void _navigateToModule(BuildContext context, String route) {
    Widget destination;

    switch (route) {
      case 'assets':
        destination = AssetList();
        break;
      case 'employees':
        destination = EmployeesList();
        break;
      case 'invoices':
        destination = InvoiceList();
        break;
      case 'print':
      case 'forms':
      case 'vendors':
      case 'refresh':
      case 'reports':
        destination = InvoiceList(); // Placeholder
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFF8FAFC),
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildModulesGrid(),
            const SizedBox(height: 32),
            _buildQuickStats(),
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
          'Asset Management',
          style: GoogleFonts.inter(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Access all management modules and tools',
          style: GoogleFonts.inter(
            fontSize: 15,
            color: const Color(0xFF64748B),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildModulesGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1200
            ? 4
            : constraints.maxWidth > 800
                ? 3
                : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.4,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: _modules.length,
          itemBuilder: (context, index) {
            return _buildModuleCard(_modules[index], index);
          },
        );
      },
    );
  }

  Widget _buildModuleCard(ManagementModule module, int index) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: GestureDetector(
        onTap: () => _navigateToModule(context, module.route),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHovered
                  ? module.color.withOpacity(0.5)
                  : const Color(0xFFE2E8F0),
              width: isHovered ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? module.color.withOpacity(0.15)
                    : const Color(0xFF0F172A).withOpacity(0.03),
                blurRadius: isHovered ? 16 : 8,
                offset: Offset(0, isHovered ? 6 : 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background pattern
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: module.color.withOpacity(0.05),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                module.color,
                                module.color.withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: module.color.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            module.icon,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        AnimatedRotation(
                          turns: isHovered ? 0.125 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            Iconsax.arrow_right_3,
                            color:
                                module.color.withOpacity(isHovered ? 1 : 0.3),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      module.title,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      module.description,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
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
                  Iconsax.chart_square,
                  color: Color(0xFF0EA5E9),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Quick Overview',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatItem(
                'Total Assets',
                '1,234',
                Iconsax.box,
                const Color(0xFF0EA5E9),
                '+12%',
                true,
              ),
              const SizedBox(width: 20),
              _buildStatItem(
                'Active Employees',
                '89',
                Iconsax.people,
                const Color(0xFF8B5CF6),
                '+5%',
                true,
              ),
              const SizedBox(width: 20),
              _buildStatItem(
                'Pending Requests',
                '7',
                Iconsax.clock,
                const Color(0xFFF59E0B),
                '-2',
                false,
              ),
              const SizedBox(width: 20),
              _buildStatItem(
                'Due Refreshes',
                '3',
                Iconsax.refresh,
                const Color(0xFFEF4444),
                'This month',
                null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
    String change,
    bool? isPositive,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 20),
                if (isPositive != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isPositive
                          ? const Color(0xFFDCFCE7)
                          : const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isPositive ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
                          size: 10,
                          color: isPositive
                              ? const Color(0xFF166534)
                              : const Color(0xFF991B1B),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          change,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: isPositive
                                ? const Color(0xFF166534)
                                : const Color(0xFF991B1B),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
                height: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isPositive == null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  change,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFF94A3B8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Data model
class ManagementModule {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final String route;

  const ManagementModule({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.route,
  });
}
