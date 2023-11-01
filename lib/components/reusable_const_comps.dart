import 'package:flutter/material.dart';

import 'leading_title_text.dart';

class ReusableConstComps {
  static Widget dividerOR() => Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Divider(
              indent: 20,
              endIndent: 10,
              color: Colors.grey.shade700,
              thickness: 1.2,
            ),
          ),
          LeadingTitleText( 'Or',
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          Expanded(
            child: Divider(
              indent: 10,
              endIndent: 20,
              color: Colors.grey.shade700,
              thickness: 1.2,
            ),
          ),
        ],
      );
}