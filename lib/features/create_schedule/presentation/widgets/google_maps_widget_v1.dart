import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
 const MapSample({super.key});

 @override
 State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
 final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

 static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
 );

 static const IconData gpsFixedSharp = IconData(0xe9d7, fontFamily: 'MaterialIcons');

 static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

 @override
 Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            bottom: 50,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: FloatingActionButton.extended(
                onPressed: _goToTheLake,
                label: const Text(''),
                icon: const Icon(gpsFixedSharp),
              ),
            ),
          ),
        ],
      ),
    );
 }

 Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
 }
}
