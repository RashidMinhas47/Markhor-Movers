import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconBtn extends StatelessWidget {
  const IconBtn(this.iconURL,
      {Key? key, this.iconColor, required this.onPressed})
      : super(key: key);
  final VoidCallback onPressed;
  final String iconURL;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      height: 70,
      minWidth: 30,
      child: SvgPicture.asset(
        iconURL,
        color: iconColor,
      ),
    );
  }
}
