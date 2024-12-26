import 'package:flutter/material.dart';

class OnscreenButton extends StatelessWidget {
  final Function() onPressed;
  final IconData? icon;
  final String label;
  final String? imageIcon;
  final double? width;
  final Color backgroundColor;
  final Gradient? gradient;
  final double? imageIconWidth;
  final double iconSize;
  final double height;

  const OnscreenButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.icon,
      this.width,
      this.height = 38,
      this.imageIconWidth,
      this.iconSize = 20,
      this.imageIcon,
      this.backgroundColor = Colors.transparent,
      this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: const Color.fromARGB(255, 48, 94, 117)),
      height: height,
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3))),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imageIcon != null) ...[
                  Image.asset(
                    imageIcon!,
                    width: imageIconWidth,
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: iconSize,
                    color: Colors.white,
                  ), // Display icon if provided
                  const SizedBox(
                      width: 10), // Add spacing between icon and text
                ],
                Text(label,
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
          )),
    );
  }
}
