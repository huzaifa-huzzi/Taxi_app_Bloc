import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kgooglePlex = const CameraPosition(target: LatLng(33.68, 73.085),zoom: 14 );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition:_kgooglePlex,
        mapType: MapType.hybrid,
        onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
        },

      ),
    );
  }
}
