import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markhor_movers/components/leading_title_text.dart';

class RideBookBtn extends StatelessWidget {
  const RideBookBtn(
      {super.key,
      required this.onTap,
      required this.btnIcon,
      required this.btnTitle});
  final String btnTitle;
  final String btnIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: 64,
                  width: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Image.asset(
                    btnIcon,
                    width: 39,
                  ),
                ),
                LeadingTitleText(
                  btnTitle,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
