import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markhor_movers/components/leading_title_text.dart';
import 'package:markhor_movers/constants/colors_scheme.dart';
import 'package:markhor_movers/constants/image_urls.dart';

import '../../../components/auth_button.dart';

class BookRide extends StatefulWidget {
  static const String scr = '/BookRide';
  const BookRide({super.key});

  @override
  State<BookRide> createState() => _BookRideState();
}

enum Vehicles {
  bike,
  car,
  none,
}

class _BookRideState extends State<BookRide> {
  Vehicles vehiclesType = Vehicles.none;
  Color vehicleColor = Colors.grey;
  onSelectBike(Vehicles vehicles) {
    switch (vehiclesType) {
      case Vehicles.bike:
        setState(() {
          vehiclesType = vehicles;
          print('.....................$vehiclesType...........');
        });
      case Vehicles.car:
        vehicleColor = kPrimaryColor;
      case Vehicles.none:
        vehicleColor = Colors.grey;
    }
  }

  TextEditingController pickPointCont = TextEditingController();
  TextEditingController endPointCont = TextEditingController();
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LeadingTitleText('Select Vihicle'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          onSelectBike(Vehicles.bike);
                        },
                        icon: Icon(
                          Icons.motorcycle_rounded,
                          color: vehiclesType == Vehicles.bike
                              ? kPrimaryColor
                              : Colors.grey,
                        ),
                        iconSize: 70,
                      ),
                      IconButton(
                        onPressed: () {
                          onSelectBike(Vehicles.car);
                          print('.............it works.........');
                        },
                        icon: Icon(
                          Icons.car_rental,
                          color: vehiclesType == Vehicles.car
                              ? kPrimaryColor
                              : Colors.grey,
                        ),
                        iconSize: 70,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        kSetLocationInd,
                        height: 100,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            PickPointField(
                              hintText: 'Enter pickup point',
                              controller: pickPointCont,
                            ),
                            PickPointField(
                              hintText: 'Where to?',
                              controller: endPointCont,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: AuthButton(
                onPressed: () {
                  final FirebaseFirestore firestore =
                      FirebaseFirestore.instance;
                  if (pickPointCont.text.isNotEmpty &&
                      endPointCont.text.isNotEmpty &&
                      FirebaseAuth.instance.currentUser != null) {
                    firestore.collection('BOOKED').add({
                      'PICKPOINT': pickPointCont.text,
                      'ENDPOINT': endPointCont.text,
                      'BOOKEDTIME': DateTime.now(),
                      'VEHICLETYPE': 'car',
                    });
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Enter details')));
                  }
                },
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
  const PickPointField({super.key, required this.hintText, this.controller});
  final String hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextField(
        controller: controller,
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
