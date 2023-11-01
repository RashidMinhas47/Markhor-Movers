import 'package:flutter/material.dart';
import 'package:markhor_movers/constants/colors_scheme.dart';

import 'leading_title_text.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    this.size,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final Size? size;
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          fixedSize: size,
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )),
      child: LeadingTitleText(
        title,
        color: Colors.white,
        fontSize: 22,
      ),
    );
  }
}
