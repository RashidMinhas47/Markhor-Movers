// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:geocoding/geocoding.dart' as location;
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:markhor_movers/constants/constants.dart';

// void main() {
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
//   GoogleMapController? mapController;
//   TextEditingController originController = TextEditingController();
//   TextEditingController destinationController = TextEditingController();
//   LocationData? currentLocation;

//   Set<Marker> markers = {};
//   PolylinePoints polylinePoints = PolylinePoints();
//   List<LatLng> polylineCoordinates = [];

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Book a Ride'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: GoogleMap(
//               onMapCreated: _onMapCreated,
//               markers: markers,
//               polylines: _buildPolylines(),
//               initialCameraPosition: const CameraPosition(
//                 target: LatLng(37.7749, -122.4194), // Default to San Francisco
//                 zoom: 12.0,
//               ),
//             ),
//           ),
//           _buildLocationSearchTextField(
//               originController, 'Enter origin location', 'origin'),
//           _buildLocationSearchTextField(destinationController,
//               'Enter destination location', 'destination'),
//           ElevatedButton(
//             onPressed: _getRoute,
//             child: const Text('Get Route'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLocationSearchTextField(
//       TextEditingController controller, String hintText, String tag) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           hintText: hintText,
//           suffixIcon: IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               _searchLocation(controller.text, tag);
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       mapController = controller;
//     });
//   }

//   Future<void> _searchLocation(String query, String tag) async {
//     List<location.Location> locations =
//         await location.locationFromAddress(query);

//     if (locations.isNotEmpty && mapController != null) {
//       // Location location = locations.first;
//       LatLng latLng =
//           LatLng(locations.first.latitude, locations.first.longitude);

//       mapController!.animateCamera(CameraUpdate.newLatLng(latLng));

//       setState(() {
//         markers.add(
//           Marker(
//             markerId: MarkerId(tag),
//             position: latLng,
//             infoWindow: InfoWindow(
//                 title: tag == 'origin'
//                     ? 'Origin Location'
//                     : 'Destination Location'),
//           ),
//         );
//       });
//     }
//   }

//   Future<void> _getCurrentLocation() async {
//     Location location = Location();
//     LocationData currentLocation = await location.getLocation();

//     setState(() {
//       this.currentLocation = currentLocation;
//     });

//     if (mapController != null && currentLocation != null) {
//       LatLng latLng =
//           LatLng(currentLocation.latitude!, currentLocation.longitude!);
//       mapController!.animateCamera(CameraUpdate.newLatLng(latLng));

//       setState(() {
//         markers.add(
//           Marker(
//             markerId: MarkerId('currentLocation'),
//             position: latLng,
//             infoWindow: InfoWindow(title: 'Current Location'),
//           ),
//         );
//       });
//     }
//   }

//   Set<Polyline> _buildPolylines() {
//     Set<Polyline> polylines = {};
//     polylines.add(Polyline(
//       polylineId: const PolylineId('route'),
//       points: polylineCoordinates,
//       color: Colors.blue,
//       width: 100,
//     ));
//     return polylines;
//   }

//   void _getRoute() async {
//     LatLng origin = _getMarkerLatLng('origin');
//     LatLng destination = _getMarkerLatLng('destination');

//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       google_api_key, // Replace with your actual Google Maps API key
//       PointLatLng(origin.latitude, origin.longitude),
//       PointLatLng(destination.latitude, destination.longitude),
//     );

//     if (result.points.isNotEmpty) {
//       // setState(() {
//       for (var point in result.points) {
//         setState(() {
//           polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//         });
//       }
//       // polylineCoordinates = _convertToLatLng(result.points);
//       // });
//     }
//   }

//   LatLng _getMarkerLatLng(String tag) {
//     Marker marker =
//         markers.firstWhere((element) => element.markerId.value == tag);
//     return LatLng(marker.position.latitude, marker.position.longitude);
//   }

//   List<LatLng> _convertToLatLng(List<PointLatLng> points) {
//     return points
//         .map((point) => LatLng(point.latitude, point.longitude))
//         .toList();
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as location;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride Booking App',
      home: RideBookingScreen(),
    );
  }
}

class RideBookingScreen extends StatefulWidget {
  @override
  _RideBookingScreenState createState() => _RideBookingScreenState();
}

class _RideBookingScreenState extends State<RideBookingScreen> {
  GoogleMapController? mapController;
  TextEditingController originController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  LocationData? currentLocation;

  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Ride'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              markers: markers,
              polylines: _buildPolylines(),
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194), // Default to San Francisco
                zoom: 12.0,
              ),
            ),
          ),
          _buildLocationSearchTextField(
              originController, 'Enter origin location', 'origin'),
          _buildLocationSearchTextField(destinationController,
              'Enter destination location', 'destination'),
          ElevatedButton(
            onPressed: _getRoute,
            child: Text('Get Route'),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSearchTextField(
      TextEditingController controller, String hintText, String tag) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _searchLocation(controller.text, tag);
            },
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  Future<void> _searchLocation(String query, String tag) async {
    List<location.Location> locations =
        await location.locationFromAddress(query);

    if (locations.isNotEmpty && mapController != null) {
      // Location location = locations.first;
      LatLng latLng =
          LatLng(locations.first.latitude, locations.first.longitude);

      mapController!.animateCamera(CameraUpdate.newLatLng(latLng));

      setState(() {
        markers.add(
          Marker(
            markerId: MarkerId(tag),
            position: latLng,
            infoWindow: InfoWindow(
                title: tag == 'origin'
                    ? 'Origin Location'
                    : 'Destination Location'),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();
    LocationData currentLocation = await location.getLocation();

    setState(() {
      this.currentLocation = currentLocation;
    });

    if (mapController != null && currentLocation != null) {
      LatLng latLng =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      mapController!.animateCamera(CameraUpdate.newLatLng(latLng));

      setState(() {
        markers.add(
          Marker(
            markerId: MarkerId('currentLocation'),
            position: latLng,
            infoWindow: InfoWindow(title: 'Current Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(1),
          ),
        );
      });
    }
  }

  Set<Polyline> _buildPolylines() {
    Set<Polyline> polylines = {};
    polylines.add(Polyline(
      polylineId: const PolylineId('route'),
      points: polylineCoordinates,
      color: Colors.blue,
      width: 5,
    ));
    return polylines;
  }

  void _getRoute() async {
    LatLng origin = _getMarkerLatLng('origin');
    LatLng destination = _getMarkerLatLng('destination');

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'YOUR_API_KEY', // Replace with your actual Google Maps API key
      PointLatLng(origin.latitude, origin.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      setState(() {
        polylineCoordinates = _convertToLatLng(result.points);
      });
    }
  }

  LatLng _getMarkerLatLng(String tag) {
    Marker marker =
        markers.firstWhere((element) => element.markerId.value == tag);
    return LatLng(marker.position.latitude, marker.position.longitude);
  }

  List<LatLng> _convertToLatLng(List<PointLatLng> points) {
    return points
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();
  }
}
