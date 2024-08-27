import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng? _center;
  Set<Marker> _markers = {};

  void _fetchLocation(
    List<dynamic> latitudeList, List<dynamic> longitudeList,
    List<dynamic> clientName, List<dynamic> address
    ) async {
    try {
      // Calculate the center of all coordinates
      double sumLat = latitudeList.reduce((a, b) => a + b);
      double sumLong = longitudeList.reduce((a, b) => a + b);
      double centerLat = sumLat / latitudeList.length;
      double centerLong = sumLong / longitudeList.length;

      setState(() {
        _center = LatLng(centerLat, centerLong);
        _addMarkers(latitudeList, longitudeList, clientName, address);
      });

      // Animate the camera to the new center
      mapController?.animateCamera(
        CameraUpdate.newLatLng(_center!),
      );
    } catch (e) {
      print('Failed to fetch location: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _addMarkers(
    List<dynamic> latitudeList, List<dynamic> longitudeList,
    List<dynamic> clientName, List<dynamic> address) {
    _markers.clear(); // Clear existing markers

    for (int i = 0; i < latitudeList.length; i++) {
      LatLng position = LatLng(latitudeList[i], longitudeList[i]);
      _markers.add(
        Marker(
          markerId: MarkerId('Location $i'),
          position: position,
          infoWindow: InfoWindow(
            title: clientName[i],
            snippet: 'Tap to view address',
            onTap: () {
              _showMarkerInfo(clientName[i], address[i]);
            },
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    }
  }

  void _showMarkerInfo(String name, String address) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(name),
          content: Text(address),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building MapScreen with center: $_center");
    return BlocBuilder<ReadProgressBloc, ProgressTrackerState>(
      builder: (context, state) {
        _fetchLocation(state.latitude, state.longitude, state.clientName, state.address);
        return LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: SizedBox(
                width: constraints.maxWidth, // Use the available width
                height: 300, // Set the height of the map
                child: _center == null
                    ? Container()
                    : GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _center!,
                          zoom: 5.0,
                        ),
                        markers: _markers,
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
