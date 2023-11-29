import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:markhor_movers/constants/constants.dart';
import 'package:markhor_movers/services/google_map_services.dart';

class MapSample extends StatefulWidget {
  static const String scr = '/MapSample';
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  GoogleMapController? mapController;
  final Completer<GoogleMapController> _controller = Completer();
  LocationData? currentLocation;
  Marker? _originMarker;
  Marker? _destinationMarker;
  List<LatLng> polycordinates = [];
  // static const LatLng origin = LatLng(37.33400927, -122.03272188);
  // static const LatLng destination = LatLng(37.33429383, -122.07700044);

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getPolyPoints(LatLng origin, LatLng destination) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(origin.latitude, origin.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    print(
        "......................${_originMarker!.position.latitude}......................");

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        setState(() {
          polycordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
    }
  }

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

  void _addMarker(LatLng pos) async {
    if (_originMarker == null ||
        (_originMarker != null && _destinationMarker != null)) {
      setState(() {
        _originMarker = Marker(
          markerId: const MarkerId("_originMarker"),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
        _destinationMarker = null;
      });
    } else {
      setState(() {
        _destinationMarker = Marker(
          markerId: const MarkerId("_destinationMarker"),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
      });
      LatLng origin = _originMarker!.position;
      LatLng destination = _destinationMarker!.position;
      getPolyPoints(
        LatLng(origin.latitude, origin.longitude),
        LatLng(destination.latitude, destination.longitude),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () => mapController!.animateCamera(
                CameraUpdate.newCameraPosition(CameraPosition(
                    target: _originMarker!.position, zoom: 14.9, tilt: 10.0))),
            child: Text(
              'origin',
              style: GoogleFonts.poppins(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            )),
        TextButton(
            onPressed: () => mapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _destinationMarker!.position,
                      zoom: 14.9,
                      tilt: 49.0,
                    ),
                  ),
                ),
            child: Text(
              'destination',
              style: GoogleFonts.poppins(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ))
      ]),
      body: Column(
        children: [
          Expanded(
            child: currentLocation != null
                ? GoogleMap(
                    initialCameraPosition:
                        GoogleMapServices.initialCameraPosition(
                            currentLocation!),
                    onMapCreated: (GoogleMapController controller) {
                      setState(() {
                        // _controller.complete(controller);
                        mapController = controller;
                      });
                    },
                    polylines: {
                      Polyline(
                          polylineId: const PolylineId("route"),
                          points: polycordinates)
                    },
                    onLongPress: _addMarker,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    markers: {
                      if (_originMarker != null) _originMarker!,
                      if (_destinationMarker != null) _destinationMarker!,
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}
