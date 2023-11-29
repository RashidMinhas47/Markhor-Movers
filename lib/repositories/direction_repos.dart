import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:markhor_movers/constants/constants.dart';

class DirectionRepos {
  static void getPolyPoints(
      {required List<LatLng> polylineCors,
      required LatLng origin,
      required LatLng destination}) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(origin.latitude, origin.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
          (PointLatLng point) => LatLng(point.latitude, point.longitude));
    }
  }
}
