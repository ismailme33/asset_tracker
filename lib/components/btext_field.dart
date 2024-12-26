import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BTextField extends StatelessWidget {
  final String label;
  final double bradius;
  final String? initialValue;
  final Function(String input) onChanged;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final bool autovalidate;
  final double fieldWidth;
  final AutovalidateMode autovalidateMode;
  final int textFieldHeight;
  final bool textFieldReadOnly;
  final TextEditingController? controller;
  final WidgetBuilder? noItemsBuilder;
  final bool autoFocus;
  final bool obscureText;
  final FocusNode? focusNode;
  final double height;
  final bool enabled;
  final bool starRequired;
  final String? errorText;
  final String hintText;

  const BTextField(
      {super.key,
      this.onTap,
      this.onFieldSubmitted,
      this.focusNode,
      this.errorText,
      required this.label,
      this.initialValue,
      required this.onChanged,
      this.validator,
      this.autovalidate = false,
      this.autoFocus = false,
      this.fieldWidth = 240,
      this.autovalidateMode = AutovalidateMode.disabled,
      this.textFieldHeight = 1,
      this.textFieldReadOnly = false,
      this.obscureText = false,
      this.controller,
      this.noItemsBuilder,
      this.bradius = 2,
      this.height = 1.1,
      this.enabled = true,
      this.starRequired = false,
      this.hintText = ''});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Text(
                label,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                ),
              ),
              if (starRequired)
                SizedBox(
                  width: 3,
                ),
              if (starRequired)
                Text(
                  '*',
                  style: GoogleFonts.roboto(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          width: fieldWidth,
          child: TextFormField(
            enabled: enabled,
            onTap: onTap,
            onFieldSubmitted: onFieldSubmitted,
            focusNode: focusNode,
            autofocus: autoFocus,
            obscureText: obscureText,
            controller: controller,
            readOnly: textFieldReadOnly,
            autovalidateMode: autovalidateMode,
            initialValue: initialValue,
            maxLines: textFieldHeight,
            style: GoogleFonts.roboto(
              height: height,
              fontSize: 16,
            ),
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.roboto(
                fontSize: 12,
                color: Colors.grey[700],
              ),
              errorText: errorText,
              fillColor: Colors.white,
              filled: true,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 9,
                horizontal: 5,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 0.5),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(bradius),
                  topRight: Radius.circular(bradius),
                  bottomLeft: const Radius.circular(2),
                  topLeft: const Radius.circular(2),
                ),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 0.3),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(bradius),
                  topRight: Radius.circular(bradius),
                  bottomLeft: const Radius.circular(2),
                  topLeft: const Radius.circular(2),
                ),
              ),
            ),
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}
