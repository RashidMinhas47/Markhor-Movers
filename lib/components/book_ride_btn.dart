import 'package:flutter/material.dart';
import 'package:markhor_movers/components/leading_title_text.dart';

class RideBookBtn extends StatelessWidget {
  const RideBookBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                child: LeadingTitleText(
                  'R',
                  color: Colors.black,
                ),
              ),
              LeadingTitleText(
                'Ride',
                fontSize: 18,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
        ],
      ),
    );
  }
}
