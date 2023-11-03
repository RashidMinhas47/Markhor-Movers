import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoTextFeild extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool? obscureText;
  final Size? size;
  final String? prefixIconURL;
  InfoTextFeild(
      {Key? key,
      this.size,
      required this.hintText,
      this.controller,
      this.obscureText = false,
      this.prefixIconURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          style: GoogleFonts.poppins(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
          ),
          // inputFormatters: [
          //   FilteringTextInputFormatter.digitsOnly,
          //   LengthLimitingTextInputFormatter(10)
          // ],
          keyboardType: TextInputType.number,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none),
            fillColor: Color.fromARGB(245, 78, 78, 78),
            hintStyle: GoogleFonts.poppins(
              color: const Color(0xFF8E8E8E),
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
