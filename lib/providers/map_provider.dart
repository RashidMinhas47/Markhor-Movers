import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider extends ChangeNotifier {
  LatLng? origin;
  LatLng? destini;

  setOrigin(LatLng newOrg) {
    origin = newOrg;
    notifyListeners();
  }

  setDestini(LatLng newDestini) {
    destini = newDestini;
    notifyListeners();
  }
}
