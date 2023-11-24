import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapServices {
  static CameraPosition initialCameraPosition(LocationData locationData) {
    if (locationData != null) {
      return CameraPosition(
        target: LatLng(locationData!.latitude!, locationData!.longitude!),
        zoom: 15.0,
      );
    } else {
      return const CameraPosition(
        target: LatLng(37.7749, -122.4194), // Default to San Francisco
        zoom: 1.0,
      );
    }
  }

  static Set<Marker> buildMarkers(LocationData locationData) {
    Set<Marker> markers = Set();

    if (locationData != null) {
      markers.add(Marker(
        markerId: MarkerId('currentLocation'),
        position: LatLng(locationData!.latitude!, locationData!.longitude!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(title: 'Current Location'),
      ));
    }

    return markers;
  }
}
