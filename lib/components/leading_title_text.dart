import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeadingTitleText extends StatelessWidget {
  LeadingTitleText(this.title,
      {Key? key,
      this.color = Colors.white,
      this.fontSize = 24,
      this.padding,
      this.textAlign,
      this.fontWeight = FontWeight.w600})
      : super(key: key);

  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      // padding:
      //     EdgeInsets.symmetric(horizontal: paddingDouble*24, vertical: paddingDouble *7 ),
      child: Text(
        title,
        textAlign: textAlign,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
