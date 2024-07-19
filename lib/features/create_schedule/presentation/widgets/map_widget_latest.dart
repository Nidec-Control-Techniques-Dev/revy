import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  final Set<Polyline> _polylines = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps with Routes'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // San Francisco coordinates
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          _addRoutes();
        },
        polylines: _polylines,
      ),
    );
  }

  void _addRoutes() {
    setState(() {
      _polylines.add(Polyline(
        polylineId: PolylineId('route1'),
        visible: true,
        points: [
          LatLng(37.7749, -122.4194),
          LatLng(37.7849, -122.4094),
        ],
        color: Colors.blue,
      ));

      _polylines.add(Polyline(
        polylineId: PolylineId('route2'),
        visible: true,
        points: [
          LatLng(37.7749, -122.4194),
          LatLng(37.7649, -122.4294),
        ],
        color: Colors.red,
      ));
    });
  }
}
