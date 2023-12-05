import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:markhor_movers/firebase_options.dart';
import 'package:markhor_movers/providers/map_provider.dart';
import 'package:markhor_movers/screens/auth/add_payment.dart';
import 'package:markhor_movers/screens/auth/check_user_status.dart';
import 'package:markhor_movers/screens/auth/create_profile.dart';
import 'package:markhor_movers/screens/auth/otp_screen.dart';
import 'package:markhor_movers/screens/home/home.dart';
import 'package:markhor_movers/screens/home/views/book_ride.dart';
import 'package:markhor_movers/screens/home/views/send_packae.dart';
import 'package:markhor_movers/screens/new_map.dart';
import 'package:markhor_movers/screens/home/views/profile.dart';
import 'package:markhor_movers/screens/trips_history.dart';
import 'dart:io' show Platform;
import 'package:provider/provider.dart';
import 'screens/auth/sign_in.dart';
import 'screens/home/views/set_destination.dart';
import 'screens/home/views/set_pickup_loc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => MapProvider())],
      child: MaterialApp(
        theme: ThemeData.dark(useMaterial3: true),
        initialRoute: UserStatus.scr,
        routes: {
          SignInScreen.scr: (_) => const SignInScreen(),
          OTPScreen.scr: (_) => const OTPScreen(),
          CreateProfile.scr: (_) => const CreateProfile(),
          AddPaymentScreen.scr: (_) => const AddPaymentScreen(),
          HomeScreen.scr: (_) => const HomeScreen(),
          SendPackage.scr: (_) => const SendPackage(),
          BookRide.scr: (_) => const BookRide(),
          MapSample.scr: (_) => const MapSample(),
          ProfileSceen.scr: (_) => const ProfileSceen(),
          UserStatus.scr: (_) => const UserStatus(),
          SetDestination.scr: (_) => const SetDestination(),
          SetOrigin.scr: (_) => const SetOrigin(),
          YourTrips.scr: (_) => const YourTrips(),
        },
      ),
    );
  }
}
///////////////////////chat Gpt try 1//////////
///
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Set Marker on Map',
//       home: MapScreen(),
//     );
//   }
// }

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? _mapController;
//   LatLng? _markerPosition;
//   LocationData? _currentLocation;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Set Marker on Map'),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(
//               target: LatLng(
//                   _currentLocation!.latitude!, _currentLocation!.longitude!),
//               zoom: 15.0,
//             ),
//             onTap: _onMapTap,
//             markers: _markerPosition != null
//                 ? {
//                     Marker(
//                       markerId: const MarkerId('selectedLocation'),
//                       position: _markerPosition!,
//                     ),
//                   }
//                 : Set<Marker>(),
//           ),
//           if (_markerPosition != null)
//             Positioned(
//               bottom: 16.0,
//               left: MediaQuery.of(context).size.width / 2 - 16.0,
//               child: Icon(
//                 Icons.location_on,
//                 color: Colors.red,
//                 size: 32.0,
//               ),
//             ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _saveMarkerPosition,
//         child: Icon(Icons.check),
//       ),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       _mapController = controller;
//     });
//   }

//   void _onMapTap(LatLng location) {
//     setState(() {
//       _markerPosition = location;
//     });
//   }

//   void _getCurrentLocation() async {
//     Location location = Location();
//     LocationData currentLocation = await location.getLocation();

//     setState(() {
//       _currentLocation = currentLocation;
//     });
//   }

//   void _saveMarkerPosition() {
//     if (_markerPosition != null) {
//       // Save the marker position to your desired storage (e.g., Firebase Firestore)
//       print('Marker Position: $_markerPosition');

//       // You can also use this position for further processing or navigation.
//     } else {
//       // Inform the user to set a marker first.
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('Please set a marker on the map.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }

//TODO://///////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Set Marker Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SetMarkerScreen(),
//     );
//   }
// }



/////////////////////////
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:google_maps_place_picker_mb/providers/place_provider.dart';
// import 'package:location/location.dart';
// import 'package:markhor_movers/constants/constants.dart';
// import 'package:markhor_movers/constants/image_urls.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Place Picker Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   PlaceProvider? provider;
//   String? placeName;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Place Picker Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () async {
//                 LocationData result = await Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => PlacePicker(
//                       apiKey: google_api_key,
//                       initialPosition: const LatLng(37.7749, -122.4194),
//                       usePlaceDetailSearch: true,
//                       searchingText: placeName,
//                       onPlacePicked: (value) {
//                         placeName = value.formattedAddress;
//                       },
//                     ),
//                   ),
//                 );

//                 if (result != null) {
//                   setState(() {
//                     placeName = result.provider ?? "No address available";
//                   });
//                 }
//               },
//               child: const Text('Open Place Picker'),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Selected Place: $placeName',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

////////////////////////////

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:markhor_movers/constants/constants.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Place Autocomplete',
//       home: PlaceAutocompleteScreen(),
//     );
//   }
// }

// class PlaceAutocompleteScreen extends StatefulWidget {
//   const PlaceAutocompleteScreen({super.key});

//   @override
//   _PlaceAutocompleteScreenState createState() =>
//       _PlaceAutocompleteScreenState();
// }

// class _PlaceAutocompleteScreenState extends State<PlaceAutocompleteScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final places = GoogleMapsPlaces(
//       apiKey: google_api_key); // Replace with your actual API key
//   Completer<GoogleMapController> _mapController = Completer();
//   LatLng? _selectedLocation;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Place Autocomplete'),
//       ),
//       body: Column(
//         children: [
//           _buildSearchTextField(),
//           Expanded(
//             child: _buildGoogleMap(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchTextField() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         controller: _searchController,
//         decoration: InputDecoration(
//           hintText: 'Search for a place...',
//           suffixIcon: IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               _searchPlaces(_searchController.text);
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildGoogleMap() {
//     return GoogleMap(
//       onMapCreated: (GoogleMapController controller) {
//         _mapController.complete(controller);
//       },
//       initialCameraPosition: CameraPosition(
//         target: LatLng(37.7749, -122.4194), // Default to San Francisco
//         zoom: 12.0,
//       ),
//       markers: _selectedLocation != null
//           ? {
//               Marker(
//                 markerId: MarkerId('selectedLocation'),
//                 position: _selectedLocation!,
//                 infoWindow: InfoWindow(title: 'Selected Location'),
//               ),
//             }
//           : Set<Marker>(),
//     );
//   }

//   Future<void> _searchPlaces(String query) async {
//     final response = await places.autocomplete(
//       query,
//       language: 'en',
//       components: [
//         Component(Component.country, 'US')
//       ], // Optional: Restrict results to a specific country
//     );

//     if (response.isOkay) {
//       final predictions = response.predictions;
//       _displayAutocompleteResults(predictions);
//     } else {
//       // Handle error
//       print('Error: ${response.errorMessage}');
//     }
//   }

//   void _displayAutocompleteResults(List<Prediction> predictions) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Select a Place'),
//           content: Column(
//             children: [
//               for (var prediction in predictions)
//                 ListTile(
//                   title: Text(prediction.description!),
//                   onTap: () {
//                     _selectPlace(prediction.placeId!);
//                   },
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _selectPlace(String placeId) async {
//     final details = await places.getDetailsByPlaceId(placeId);

//     if (details.isOkay) {
//       final location = details.result.geometry!.location;
//       final controller = await _mapController.future;

//       controller.animateCamera(
//           CameraUpdate.newLatLng(LatLng(location.lat, location.lng)));

//       setState(() {
//         _selectedLocation = LatLng(location.lat, location.lng);
//         _searchController.text = details.result.formattedAddress!;
//       });
//     } else {
//       // Handle error
//       print('Error: ${details.errorMessage}');
//     }
//   }
// }

//////////////////////
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:markhor_movers/firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Ride Booking App',
//       home: RideBookingScreen(),
//     );
//   }
// }

// class RideBookingScreen extends StatefulWidget {
//   @override
//   _RideBookingScreenState createState() => _RideBookingScreenState();
// }

// class _RideBookingScreenState extends State<RideBookingScreen> {
//   final TextEditingController _originController = TextEditingController();
//   final TextEditingController _destinationController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Book a Ride'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Enter Origin:'),
//             TextField(controller: _originController),
//             SizedBox(height: 16.0),
//             Text('Enter Destination:'),
//             TextField(controller: _destinationController),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _bookRide,
//               child: Text('Book Ride'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _bookRide() async {
//     String origin = _originController.text;
//     String destination = _destinationController.text;

//     if (origin.isNotEmpty && destination.isNotEmpty) {
//       // Add the ride details to Firebase Firestore
//       await FirebaseFirestore.instance.collection('rides').add({
//         'origin': origin,
//         'destination': destination,
//         'timestamp': FieldValue.serverTimestamp(),
//       });

//       // Clear the input fields
//       _originController.clear();
//       _destinationController.clear();

//       // Show a success message
//       _showSuccessDialog();
//     } else {
//       // Show an error message if the fields are empty
//       _showErrorDialog();
//     }
//   }

//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Success'),
//           content: Text('Ride booked successfully!'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showErrorDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Error'),
//           content: const Text('Please enter both origin and destination.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

// }
