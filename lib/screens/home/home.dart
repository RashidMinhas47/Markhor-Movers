import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:markhor_movers/components/book_ride_btn.dart';
import 'package:markhor_movers/components/leading_title_text.dart';
import 'package:markhor_movers/constants/colors_scheme.dart';
import 'package:markhor_movers/constants/constants.dart';
import 'package:markhor_movers/constants/image_urls.dart';
import 'package:markhor_movers/screens/home/views/book_ride.dart';
import 'package:markhor_movers/screens/home/views/send_packae.dart';
import 'package:markhor_movers/screens/home/views/profile.dart';

class HomeScreen extends StatefulWidget {
  static const String scr = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final _auth = FirebaseAuth.instance;
  final _ridesCollectionSnaps = FirebaseFirestore.instance;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kScaffolColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, ProfileSceen.scr);
          },
        ),
        backgroundColor: kPrimaryColor,
      ),
      //..
      body: Center(
        child: Column(
          children: [
            Container(
              height: size.height * 0.34,
              width: size.width,
              color: kPrimaryColor,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LeadingTitleText(
                      'To find your pickup location automatically, turn on location services',
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("Turn on location")),
                    )
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RideBookBtn(
                  btnIcon: kRideIcon,
                  btnTitle: 'Rider',
                  onTap: () {
                    Navigator.pushNamed(context, BookRide.scr);
                  },
                ),
                const Gap(20),
                RideBookBtn(
                  btnIcon: kPackageIcon,
                  btnTitle: 'Package',
                  onTap: () {
                    Navigator.pushNamed(context, SendPackage.scr);
                  },
                )
              ],
            ),
            // Container(
            //   alignment: Alignment.centerLeft,
            //   height: 65,
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   width: size.width * 0.9,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       color: kDarkGreyColor),
            //   child: LeadingTitleText(
            //     'Enter pickup point',
            //     textAlign: TextAlign.center,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            const Gap(30),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: _ridesCollectionSnaps
                        .collection(RIDES)
                        .doc(_auth.currentUser!.email)
                        .collection(YOURRIDES)
                        .snapshots(),
                    builder: (context, snapshot) {
                      final origin = snapshot.data!.docs[0].data();
                      if (snapshot.hasData) {
                        return GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: _kGooglePlex,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          markers: {
                            Marker(
                                markerId: const MarkerId('Origin'),
                                position: LatLng(
                                    origin['origin'][0], origin['origin'][1])),
                            Marker(
                                markerId: const MarkerId('destination'),
                                position: LatLng(origin['destination'][0],
                                    origin['destination'][1]))
                          },
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
