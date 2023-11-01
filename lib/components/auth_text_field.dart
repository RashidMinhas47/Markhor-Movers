import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final Size? size;
  final String prefixIconURL;
  AuthTextField(
      {Key? key,
      this.size,
      required this.hintText,
      required this.controller,
      this.obscureText = false,
      required this.prefixIconURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '+92',
            style: GoogleFonts.poppins(fontSize: 24, color: Colors.white),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller,
              style: GoogleFonts.poppins(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10)
              ],
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
        ),
        Spacer(),
      ],
    );
  }
}
