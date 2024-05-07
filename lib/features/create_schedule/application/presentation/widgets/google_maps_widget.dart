import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  double lat = 0.0;
  double long=0.0;

  CameraPosition _kGooglePlex = CameraPosition(
    target: const LatLng(14.866056, 120.859948),
    zoom: 14.4746,
  );

  static const IconData gpsFixedSharp = IconData(0xe9d7, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          onPressed: _goToCurrentLocation,
          label: const Text('To My Location'),
          icon: const Icon(gpsFixedSharp),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

Future<void> _goToCurrentLocation() async {
  final GoogleMapController controller = await _controller.future;
  Position position = await _determinePosition();
  print("Navigating to: ${position.latitude}, ${position.longitude}");

  CameraPosition newCameraPosition = CameraPosition(
    target: LatLng(position.latitude, position.longitude),
    zoom: 19.151926040649414,
  );

  controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
}


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
