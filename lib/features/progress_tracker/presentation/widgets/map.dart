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

  final LatLng _center =
      const LatLng(37.7749, -122.4194); // San Francisco coordinates

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _addMarkers() {
    final List<LatLng> markerPositions = [
      const LatLng(37.7749, -122.4194), // San Francisco
      const LatLng(34.0522, -118.2437), // Los Angeles
      const LatLng(40.7128, -74.0060), // New York
      const LatLng(41.8781, -87.6298), // Chicago
      const LatLng(29.7604, -95.3698), // Houston
    ];

    final List<String> markerTitles = [
      'San Francisco',
      'Los Angeles',
      'New York',
      'Chicago',
      'Houston',
    ];

    for (int i = 0; i < markerPositions.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(markerTitles[i]),
          position: markerPositions[i],
          infoWindow: InfoWindow(
            title: markerTitles[i],
            snippet: 'Tap to see more',
            onTap: () {
              _showMarkerInfo(markerTitles[i]);
            },
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    }
  }

  void _showMarkerInfo(String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('This is $title.'),
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
    return BlocBuilder<ReadProgressBloc, ProgressTrackerState>(
      builder: (context, state) {
        if (state is DataError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Center(
          child: SizedBox(
            width: 350, // Set the width of the map
            height: 300, // Set the height of the map
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 4.0,
              ),
              markers: _markers,
            ),
          ),
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Google Maps Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: MapScreen(),
// //     );
// //   }
// // }

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? mapController;

//   final LatLng _center = const LatLng(37.7749, -122.4194); // San Francisco coordinates

//   final Set<Marker> _markers = {};

//   @override
//   void initState() {
//     super.initState();
//     _addMarkers();
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   void _addMarkers() {
//     final List<LatLng> markerPositions = [
//       const LatLng(37.7749, -122.4194), // San Francisco
//       const LatLng(34.0522, -118.2437), // Los Angeles
//       const LatLng(40.7128, -74.0060),  // New Yorks
//       const LatLng(41.8781, -87.6298),  // Chicago
//       const LatLng(29.7604, -95.3698),  // Houston
//     ];

//     final List<String> markerTitles = [
//       'San Francisco',
//       'Los Angeles',
//       'New York',
//       'Chicago',
//       'Houston',
//     ];

//     for (int i = 0; i < markerPositions.length; i++) {
//       _markers.add(
//         Marker(
//           markerId: MarkerId(markerTitles[i]),
//           position: markerPositions[i],
//           infoWindow: InfoWindow(
//             title: markerTitles[i],
//             snippet: 'Tap to see more',
//             onTap: () {
//               _showMarkerInfo(markerTitles[i]);
//             },
//           ),
//           icon: BitmapDescriptor.defaultMarker,
//         ),
//       );
//     }
//   }

//   void _showMarkerInfo(String title) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text('This is $title.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Close'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Google Maps Demo'),
//       ),
//       body: Center(
//         child: SizedBox(
//           width: 300, // Set the width of the map
//           height: 300, // Set the height of the map
//           child: GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(
//               target: _center,
//               zoom: 4.0,
//             ),
//             markers: _markers,
//           ),
//         ),
//       ),
//     );
//   }
// }
