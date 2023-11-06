import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markhor_movers/constants/colors_scheme.dart';
import 'package:markhor_movers/constants/image_urls.dart';

class BookRide extends StatelessWidget {
  static const String scr = '/BookRide';
  const BookRide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(kSetLocationInd),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: TextField(
                      style: GoogleFonts.inter(),
                      decoration: InputDecoration(
                        fillColor: kDefaultIconDarkColor.withOpacity(0.49),
                        filled: true,
                        hintText: 'Enter pickup point',
                        hintStyle: GoogleFonts.inter(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      )),
    );
  }
}
