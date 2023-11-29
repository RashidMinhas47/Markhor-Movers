import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:markhor_movers/components/leading_title_text.dart';
import 'package:markhor_movers/constants/colors_scheme.dart';
import 'package:markhor_movers/constants/constants.dart';
import 'package:markhor_movers/constants/image_urls.dart';
import 'package:markhor_movers/repositories/network_utilities.dart';

import '../../../components/auth_button.dart';
import '../../../components/enter_address_text_field.dart';

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
  late LocationData currentLocation;
  TextEditingController pickPointCont = TextEditingController();
  TextEditingController endPointCont = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  String vehicleName = 'none';

  // void placeAutoComplete(String query) async {
  //   Uri uri =
  //       Uri.https("maps.googleapis.com", 'maps/api/place/autocomplete/json', {
  //     "input": query,
  //     "key": google_api_key,
  //   });
  //   String? response = await NetworkUtility.fetchUrl(uri);
  //   if (response != null) {
  //     print(response + 'YOUR SEARCH IS:$query');
  //   }
  // }

  void getLocation() {
    Location location = Location();
    try {
      location.getLocation().then((location) {
        LocationData locationData = location;
        setState(() {
          currentLocation = locationData;
        });
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

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
                          setState(() {
                            vehiclesType = Vehicles.bike;
                            vehicleName = 'bike';
                          });
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
                          setState(() {
                            vehiclesType = Vehicles.car;
                            vehicleName = "car";
                          });
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
                              onChanged: (value) {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => PlacePicker(
                                //       apiKey: Platform.isAndroid
                                //           ? "YOUR ANDROID API KEY"
                                //           : "YOUR IOS API KEY",
                                //       onPlacePicked: (result) {
                                //         print(result.address);
                                //         Navigator.of(context).pop();
                                //       },
                                //       initialPosition:
                                //           HomeS.kInitialPosition,
                                //       useCurrentLocation: true,
                                //       resizeToAvoidBottomInset:
                                //           false, // only works in page mode, less flickery, remove if wrong offsets
                                //     ),
                                //   ),
                                // );
                              },
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
            Expanded(
              child: currentLocation.latitude == null
                  ? loaderWidget
                  : GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation.latitude!,
                              currentLocation.longitude!),
                          zoom: 14.0),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      markers: {},
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: AuthButton(
                onPressed: () {
                  BookRideRepos().bookRide(context,
                      originCont: pickPointCont, destinationCont: endPointCont);
                  // final FirebaseFirestore firestore =
                  //     FirebaseFirestore.instance;
                  // if (pickPointCont.text.isNotEmpty &&
                  //     endPointCont.text.isNotEmpty &&
                  //     FirebaseAuth.instance.currentUser != null) {
                  //   firestore.collection('BOOKED').add({
                  //     'PICKPOINT': pickPointCont.text,
                  //     'ENDPOINT': endPointCont.text,
                  //     'BOOKEDTIME': DateTime.now(),
                  //     'VEHICLETYPE': vehicleName,
                  //   });
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //       backgroundColor: kDarkGreyColor,
                  //       content: Text(
                  //         'Enter details',
                  //         style: GoogleFonts.poppins(
                  //             color: Colors.white, fontSize: 17),
                  //       )));
                  // }
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

class BookRideRepos {
  static BookRide instance = const BookRide();
  void bookRide(BuildContext context,
      {required TextEditingController originCont,
      required TextEditingController destinationCont}) async {
    String origin = originCont.text;
    String destination = destinationCont.text;

    if (origin.isNotEmpty && destination.isNotEmpty) {
      // Add the ride details to Firebase Firestore
      await FirebaseFirestore.instance.collection('rides').add({
        'origin': origin,
        'destination': destination,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear the input fields
      originCont.clear();
      destinationCont.clear();

      // Show a success message
      _showSuccessDialog(context);
    } else {
      // Show an error message if the fields are empty
      _showErrorDialog(context);
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Ride booked successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please enter both origin and destination.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

const loaderWidget = Column(
  children: [Text("Loading"), CircularProgressIndicator()],
);
