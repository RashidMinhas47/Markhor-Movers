import 'package:flutter/material.dart';
import 'package:markhor_movers/components/leading_title_text.dart';
import 'package:markhor_movers/components/set_location.dart';

import '../constants/colors_scheme.dart';

class PickLocationBtn extends StatelessWidget {
  const PickLocationBtn(
    this.title, {
    super.key,
    required this.size,
    required this.onPressed,
  });

  final Size size;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.centerLeft,
        height: 67,
        width: size.width * 0.9,
        decoration: BoxDecoration(
            color: kDefaultIconDarkColor.withOpacity(0.40),
            borderRadius: BorderRadius.circular(12)),
        child: LeadingTitleText(
          title,
          fontSize: 20,
          color: kPrimaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
