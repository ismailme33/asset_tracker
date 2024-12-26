import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CommonWidgets {
  static TextFormField formField({
    required String lable,
    required final controller,
    required IconData icon,
    IconData? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          label: Text(lable),
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null),
    );
  }

  static SizedBox button({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 45,
      width: 400,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        label: Text(label),
        icon: Icon(icon),
      ),
    );
  }

  static Container TopBar(String label) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: const Color.fromARGB(255, 34, 34, 34),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/logo.png',
                width: 170,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                label,
                style: GoogleFonts.roboto(
                    color: const Color.fromARGB(255, 220, 220, 220),
                    fontSize: 18),
              ),
            ],
          ),
          Row(
            children: [
              Stack(
                children: [
                  Icon(
                    Iconsax.notification,
                    color: Colors.grey[200],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 15,
                      width: 15,
                      color: Colors.red,
                      child: const Center(
                          child: Text(
                        '1',
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(100)),
                child: const Center(
                  child: Icon(
                    Iconsax.user,
                    size: 15,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ismail Ibrahim',
                    style: GoogleFonts.roboto(
                      fontSize: 13,
                      color: Colors.grey[300],
                    ),
                  ),
                  Text(
                    'IT Support',
                    style: GoogleFonts.roboto(
                      fontSize: 10,
                      color: Colors.grey[500],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
