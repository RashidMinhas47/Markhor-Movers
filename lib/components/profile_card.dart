import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/image_urls.dart';
import 'leading_title_text.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), color: Colors.red),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 30,
            child: Center(
                child: SvgPicture.asset(
              personIcon,
              fit: BoxFit.contain,
              width: 70,
            )),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeadingTitleText(
                'Rashid Minhas Sheikh',
                fontSize: 20,
                color: Colors.white,
              ),
              LeadingTitleText(
                'rashidminhassheikh47@gmail.com',
                fontSize: 14,
                color: Colors.white,
              )
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(10),
          )
        ],
      ),
    );
  }
}
