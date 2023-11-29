import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PickPointField extends StatelessWidget {
  const PickPointField(
      {super.key, required this.hintText, this.controller, this.onChanged});
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: GoogleFonts.inter(),
        decoration: InputDecoration(
          fillColor: kDefaultIconDarkColor.withOpacity(0.49),
          filled: true,
          hintText: hintText,
          hintStyle: GoogleFonts.inter(),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
