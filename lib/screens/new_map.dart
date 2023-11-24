import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:markhor_movers/services/google_map_services.dart';

class MapSample extends StatefulWidget {
  static const String scr = '/MapSample';
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  GoogleMapController? mapController;
  LocationData? currentLocation;
  Location location = Location();
  Marker? _originMarker;
  Marker? _destinationMarker;

  @override
  void initState() {
    super.initState();

    getLocation();
    setState(() {});
  }

  Future<void> getLocation() async {
    var location = Location();
    try {
      LocationData getLocation = await location.getLocation();

      setState(() {
        currentLocation = getLocation;
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _addMarker(LatLng pos) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () => mapController!.animateCamera(
                CameraUpdate.newCameraPosition(CameraPosition(
                    target: _originMarker!.position, zoom: 14.9, tilt: 49.0))),
            child: Text(
              'origin',
              style: GoogleFonts.poppins(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            )),
        TextButton(
            onPressed: () => mapController!.animateCamera(
                CameraUpdate.newCameraPosition(CameraPosition(
                    target: _destinationMarker!.position,
                    zoom: 14.9,
                    tilt: 49.0))),
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
            child: GoogleMap(
              initialCameraPosition:
                  GoogleMapServices.initialCameraPosition(currentLocation!),
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  // _controller.complete(controller);
                  mapController = controller;
                });
              },
              onLongPress: _addMarker,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: {
                if (_originMarker != null) _originMarker!,
                if (_destinationMarker != null) _destinationMarker!,
              },
            ),
          ),
        ],
      ),
    );
  }
}
