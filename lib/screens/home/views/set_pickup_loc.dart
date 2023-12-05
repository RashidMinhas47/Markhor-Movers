import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:markhor_movers/providers/map_provider.dart';
import 'package:markhor_movers/components/set_location.dart';
import 'package:provider/provider.dart';

class SetOrigin extends StatefulWidget {
  static const String scr = '/SetOrigin';
  const SetOrigin({super.key});

  @override
  State<SetOrigin> createState() => _SetOriginState();
}

class _SetOriginState extends State<SetOrigin> {
  GoogleMapController? mapController;
  LocationData? currentLocation;
  LatLng? selectedLocation;
  Marker? newLocMarker;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SetMarkerScreen(
      onMapCreated: _onMapCreated,
      onTap: _onMapTap,
      markers: {if (_buildMarkers() != null) _buildMarkers()!},
      initialCameraPosition: CameraPosition(
          zoom: 14.0,
          target:
              LatLng(currentLocation!.latitude!, currentLocation!.longitude!)),
      fabBTNTab: _setMarker,
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  Future<LocationData?> _getCurrentLocation() async {
    Location location = Location();
    LocationData newLocation = await location.getLocation();

    setState(() {
      currentLocation = newLocation;
    });

    return currentLocation;
  }

  void _onMapTap(LatLng tappedLocation) {
    setState(() {
      selectedLocation = tappedLocation;
    });
  }

  Marker? _buildMarkers() {
    Set<Marker> markers = {};

    if (selectedLocation != null) {
      newLocMarker = Marker(
        markerId: const MarkerId('selectedLocation'),
        position: selectedLocation!,
      );
      markers.add(
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: selectedLocation!,
        ),
      );
    }

    return newLocMarker;
  }

  void _setMarker() {
    if (selectedLocation != null) {
      final mapProvider = Provider.of<MapProvider>(context, listen: false);

      mapProvider.setOrigin(selectedLocation!);
      Navigator.pop(context);
    } else {
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          color: Colors.orange,
          messageFontSize: 12,
          titleFontSize: 14.9,
          title: 'Remember!',
          message: 'Please tap on map and select the pickup location!',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.warning,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
