import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markhor_movers/components/select_vihivle.dart';
import 'package:markhor_movers/components/set_location_btn.dart';
import 'package:markhor_movers/models/ride_book.dart';
import 'package:markhor_movers/providers/map_provider.dart';
import 'package:markhor_movers/screens/home/views/set_destination.dart';
import 'package:markhor_movers/screens/home/views/set_pickup_loc.dart';
import 'package:markhor_movers/services/ride_request.dart';
import 'package:markhor_movers/services/rides_history.dart';
// import 'package:markhor_movers/services/firestore_book_services.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:markhor_movers/constants/image_urls.dart';

import '../../../components/auth_button.dart';

class BookRide extends StatefulWidget {
  static const String scr = '/BookRide';
  static LatLng? origin;

  const BookRide({
    super.key,
  });

  @override
  State<BookRide> createState() => _BookRideState();
}

class _BookRideState extends State<BookRide> {
  Vehicles vehiclesType = Vehicles.none;
  Marker? originMarker;
  Marker? destinationMarker;
  late LocationData currentLocation;
  TextEditingController pickPointCont = TextEditingController();
  TextEditingController endPointCont = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  String vehicleName = 'none';
  final _auth = FirebaseAuth.instance;

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
  void dispose() {
    super.dispose();
  }
  // setOriginMarker() {
  // LatLng newPos = Provider.of<MapProvider>(context).origin!;
  // originMarker = Marker(
  //     markerId: const MarkerId('originMarker'),
  //     position: newPos,
  //     icon: BitmapDescriptor.defaultMarkerWithHue(200));

  //   print('...................${BookRide.origin}............IS THIS');
  // } else {
  //   print('......NOT SET YET......');
  // }
  // }
  RideRequestService rideRequestService = RideRequestService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    // setOriginMarker();
  }

  void makeRideRequest(MapProvider mapProvider) async {
    // You should replace this with the actual user ID
    final String userName = _auth.currentUser!.email!;

    // final newOrg = originMarker!.position;
    // final newDestini = destinationMarker!.position;
    LatLng origin = mapProvider.origin!;
    LatLng destination = mapProvider.destini!;
    if (mapProvider.destini != null && mapProvider.origin != null) {
      await rideRequestService.makeRideRequest(
          userName,
          [origin.latitude, origin.longitude],
          [destination.latitude, destination.longitude]);
      // Optionally, you can navigate to another screen or show a success message
      // Close the current screen after making the request
      showDialog(
          context: context,
          builder: (context) => Drawer(
                child: Container(
                  height: 400,
                  width: 400,
                ),
              ));
    } else {
      // Show an error message if either pickup or destination location is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both pickup and destination locations.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);
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
                  SelecVihivleComp(
                    vehiclesType: vehiclesType,
                    onBikeTap: () {
                      setState(() {
                        vehiclesType = Vehicles.bike;
                        vehicleName = 'bike';
                      });
                    },
                    onCarTap: () {
                      setState(() {
                        vehiclesType = Vehicles.car;
                        vehicleName = "car";
                      });
                      print('.............it works.........');
                    },
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
                            PickLocationBtn(
                              "Pick point",
                              size: size,
                              onPressed: () {
                                Navigator.pushNamed(context, SetOrigin.scr);
                              },
                            ),
                            PickLocationBtn(
                              'End point',
                              size: size,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SetDestination.scr);
                              },
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
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        currentLocation.latitude!, currentLocation.longitude!),
                    zoom: 14.0),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                markers: {
                  if (mapProvider.origin != null)
                    Marker(
                      onTap: () {},
                      infoWindow: const InfoWindow(title: 'Pickup location'),
                      markerId: const MarkerId('originMarker'),
                      position: mapProvider.origin!,
                      icon: BitmapDescriptor.defaultMarker,
                    ),
                  if (mapProvider.destini != null)
                    Marker(
                        infoWindow:
                            const InfoWindow(title: 'Destination location'),
                        markerId: const MarkerId('destinationMarker'),
                        position: mapProvider.destini!,
                        icon: BitmapDescriptor.defaultMarkerWithHue(100))
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: AuthButton(
                onPressed: () => makeRideRequest(mapProvider),
                title: mapProvider != null
                    ? 'Confirm Destination'
                    : 'Not set origin',
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

onCnfrimDestination() async {
  // LatLng origin = mapProvider.origin!;
  // LatLng destination = mapProvider.destini!;

  // if (mapProvider.origin != null &&
  //     mapProvider.destini != null) {
  //   try {
  //     final RidesHistory firestoreService = RidesHistory();
  //     final _auth = FirebaseAuth.instance;
  //     User user = _auth.currentUser!;
  //     // Creating a sample RideBooking instance
  //     RideBookingModel rideBooking = RideBookingModel(
  //       passengerName: user.displayName!,
  //       destination: [
  //         destination.latitude,
  //         destination.longitude
  //       ],
  //       pickupTime: DateTime.now(),
  //       origin: [origin.latitude, origin.longitude],
  //     );

  //     // Adding the ride booking to Firestore
  //     await firestoreService.addRideBooking(rideBooking);
  //   } catch (e) {
  //     print(e);
  //   }
  // } else {
  //   final snackBar = SnackBar(
  //     /// need to set following properties for best effect of awesome_snackbar_content
  //     elevation: 0,
  //     behavior: SnackBarBehavior.floating,
  //     padding: const EdgeInsets.symmetric(
  //         horizontal: 30, vertical: 30),
  //     duration: const Duration(seconds: 3),
  //     backgroundColor: Colors.transparent,
  //     content: AwesomeSnackbarContent(
  //       color: Colors.orange,
  //       messageFontSize: 12,
  //       titleFontSize: 14.9,
  //       title: 'Remember!',
  //       message: 'Please set the requaired locations!',

  //       /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
  //       contentType: ContentType.warning,
  //     ),
  //   );

  //   ScaffoldMessenger.of(context)
  //     ..hideCurrentSnackBar()
  //     ..showSnackBar(snackBar);
  // }
  // // BookRideRepos().bookRide(context,
  //     originCont: pickPointCont, destinationCont: endPointCont);
  // final FirebaseFirestore firestore =
  //     FirebaseFirestore.instance;
  // if (pickPointCont.text.isNotEmpty &&
  //     endPointCont.text.isNotEmpty &&
  //     FirebaseAuth.instance.currentUser != null) {
  //   firestore.collection('BOOKED').add({
  //     'PICKPOINT': mapProvider.origin,
  //     'ENDPOINT': mapProvider.destini,
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
  // }
}
