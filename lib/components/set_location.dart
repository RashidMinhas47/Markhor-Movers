import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:markhor_movers/providers/map_provider.dart';
import 'package:markhor_movers/screens/home/views/book_ride.dart';
import 'package:provider/provider.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class SetMarkerScreen extends StatelessWidget {
  SetMarkerScreen(
      {super.key,
      this.onMapCreated,
      required this.initialCameraPosition,
      required this.markers,
      required this.fabBTNTab,
      this.onTap});
  final MapCreatedCallback? onMapCreated;

  final CameraPosition initialCameraPosition;

  final Set<Marker> markers;
  final VoidCallback fabBTNTab;

  final ArgumentCallback<LatLng>? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Pickup Point'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  onMapCreated: onMapCreated,
                  initialCameraPosition: initialCameraPosition,
                  onTap: onTap,
                  markers: markers,
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fabBTNTab,
        child: const Icon(Icons.check),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////


///////////////////////////////////////////////
