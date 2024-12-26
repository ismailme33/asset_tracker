import 'package:asset_tracker/Employees/employees_list.dart';
import 'package:asset_tracker/Invoices/invoice_create.dart';
import 'package:asset_tracker/Invoices/invoice_list.dart';
import 'package:asset_tracker/asset_list.dart';
import 'package:asset_tracker/components/onscreen_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AssetPage extends StatelessWidget {
  const AssetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.blueGrey[100],
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: [
          OnscreenButton(
              icon: Iconsax.devices,
              width: 170,
              label: 'Assets',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssetList(),
                    ));
              }),
          OnscreenButton(
              icon: Iconsax.people,
              width: 170,
              label: 'Emplyees ',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeesList(),
                    ));
              }),
          OnscreenButton(
              icon: Iconsax.receipt,
              width: 170,
              label: 'Invoices ',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvoiceList(),
                    ));
              }),
          OnscreenButton(
              icon: Iconsax.printer,
              width: 170,
              label: 'Print Counts ',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvoiceList(),
                    ));
              }),
          OnscreenButton(
              icon: Iconsax.document,
              width: 170,
              label: 'IT Forms ',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvoiceList(),
                    ));
              }),
          OnscreenButton(
              icon: Iconsax.building,
              width: 220,
              label: 'Vendors & Suppliers ',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvoiceList(),
                    ));
              }),
          OnscreenButton(
              icon: Iconsax.calendar,
              width: 170,
              label: 'Tech Rrfresh ',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InvoiceList(),
                    ));
              }),
        ],
      ),
    );
  }
}
