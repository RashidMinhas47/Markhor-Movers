import 'package:flutter/material.dart';
import 'package:markhor_movers/components/leading_title_text.dart';
import 'package:markhor_movers/constants/colors_scheme.dart';

class SelecVihivleComp extends StatelessWidget {
  const SelecVihivleComp({
    super.key,
    required this.vehiclesType,
    required this.onBikeTap,
    required this.onCarTap,
  });

  final Vehicles vehiclesType;
  final VoidCallback onBikeTap;
  final VoidCallback onCarTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LeadingTitleText('Select Vihicle'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onBikeTap,
              icon: Icon(
                Icons.motorcycle_rounded,
                color:
                    vehiclesType == Vehicles.bike ? kPrimaryColor : Colors.grey,
              ),
              iconSize: 70,
            ),
            IconButton(
              onPressed: onCarTap,
              icon: Icon(
                Icons.car_rental,
                color:
                    vehiclesType == Vehicles.car ? kPrimaryColor : Colors.grey,
              ),
              iconSize: 70,
            ),
          ],
        ),
      ],
    );
  }
}

enum Vehicles {
  bike,
  car,
  none,
}
