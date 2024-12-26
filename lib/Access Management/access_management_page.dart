import 'package:asset_tracker/asset_list.dart';
import 'package:asset_tracker/components/onscreen_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AccessManagementPage extends StatelessWidget {
  const AccessManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.blueGrey[100],
      padding: EdgeInsets.all(10),
      child: Wrap(
        spacing: 10,
        children: [
          OnscreenButton(
              icon: Iconsax.user,
              width: 150,
              label: 'Users',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssetList(),
                    ));
              }),
          OnscreenButton(
              icon: Iconsax.lock,
              width: 170,
              label: 'Groups ',
              onPressed: () {}),
        ],
      ),
    );
  }
}
