import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markhor_movers/constants/image_urls.dart';

import '../../../components/auth_button.dart';

class BookRide extends StatelessWidget {
  static const String scr = '/BookRide';
  const BookRide({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  kSetLocationInd,
                  height: 100,
                ),
                const Expanded(
                  child: Column(
                    children: [
                      PickPointField(hintText: 'Enter pickup point'),
                      PickPointField(hintText: 'Where to?'),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: AuthButton(
                onPressed: () {},
                title: 'Confirm Destination',
                size: Size(size.width * 0.9, 59),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class PickPointField extends StatelessWidget {
  const PickPointField({super.key, required this.hintText});
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextField(
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
