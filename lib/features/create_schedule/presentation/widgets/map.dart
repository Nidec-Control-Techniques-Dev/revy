import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:revy/features/create_schedule/bloc/create_schedule_bloc.dart';
import '../../data/datasources/remote/geocode_data_source.dart';
import 'package:dio/dio.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng? _center;
  Set<Marker> _markers = {};

  @override
  void didUpdateWidget(MapScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final state = context.read<CreateScheduleBloc>().state;
    _fetchLocation(state.startLocation);
  }

  void _fetchLocation(String address) async {
    try {
      // Fetch the location data asynchronously
      final GeocodingApiDataSource dataSource = GeocodingApiDataSource(Dio());
      final locationData = await dataSource.geocodeAddress(address); // Replace with actual address
      print("-------");
      print(locationData);
      print("-------");
      setState(() {
        _center = LatLng(locationData['lat'], locationData['lng']);
        _addMarkers(_center!);
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

  void _addMarkers(LatLng position) {
    _markers.clear(); // Clear existing markers
    _markers.add(
      Marker(
        markerId: MarkerId('Chosen Location'),
        position: position,
        infoWindow: InfoWindow(
          title: 'Chosen Location',
          snippet: 'Tap to see more',
          onTap: () {
            _showMarkerInfo('Chosen Location');
          },
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
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
    return BlocBuilder<CreateScheduleBloc, CreateScheduleState>(
      builder: (context, state) {
        return Center(
          child: SizedBox(
            width: 350, // Set the width of the map
            height: 300, // Set the height of the map
            child: _center == null
                ? Container()
                : GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center!,
                      zoom: 13.0,
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
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:revy/features/create_schedule/bloc/create_schedule_bloc.dart';
// import '../../data/datasources/remote/geocode_data_source.dart';
// import 'package:dio/dio.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? mapController;
//   LatLng? _center;
//   Set<Marker> _markers = {};

//   void _fetchLocation(String address) async {
//     try {
//       // Fetch the location data asynchronously
//       final GeocodingApiDataSource dataSource = GeocodingApiDataSource(Dio());
//       final locationData = await dataSource.geocodeAddress(address); // Replace with actual address
//       print("-------");
//       print(locationData);
//       print("-------");
//       setState(() {
//         _center = LatLng(locationData['lat'], locationData['lng']);
//         _addMarkers(_center!);
//       });
//       // Animate the camera to the new center
//       mapController?.animateCamera(
//         CameraUpdate.newLatLng(_center!),
//       );
//     } catch (e) {
//       print('Failed to fetch location: $e');
//     }
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   void _addMarkers(LatLng position) {
//     _markers.clear(); // Clear existing markers
//     _markers.add(
//       Marker(
//         markerId: MarkerId('Chosen Location'),
//         position: position,
//         infoWindow: InfoWindow(
//           title: 'Chosen Location',
//           snippet: 'Tap to see more',
//           onTap: () {
//             _showMarkerInfo('Chosen Location');
//           },
//         ),
//         icon: BitmapDescriptor.defaultMarker,
//       ),
//     );
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
//     return BlocBuilder<CreateScheduleBloc, CreateScheduleState>(
//       builder: (context, state) {
//         _fetchLocation(state.startLocation);
//         return Center(
//           child: SizedBox(
//             width: 350, // Set the width of the map
//             height: 300, // Set the height of the map
//             child: _center == null
//                 ? Container()
//                 : GoogleMap(
//                     onMapCreated: _onMapCreated,
//                     initialCameraPosition: CameraPosition(
//                       target: _center!,
//                       zoom: 13.0,
//                     ),
//                     markers: _markers,
//                   ),
//           ),
//         );
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:revy/features/create_schedule/bloc/create_schedule_bloc.dart';
// import '../../data/datasources/remote/geocode_data_source.dart';
// import 'package:dio/dio.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? mapController;
//   LatLng? _center;
//   Set<Marker> _markers = {};

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   // Fetch location when the widget is initialized
//   //   _fetchLocation();
//   // }

//   void _fetchLocation(String address) async {
//     try {
//       // Fetch the location data asynchronously
//       final GeocodingApiDataSource dataSource = GeocodingApiDataSource(Dio());
//       final locationData = await dataSource.geocodeAddress(address); // Replace with actual address
//       print("-------");
//       print(locationData);
//       print("-------");
//       setState(() {
//         _center = LatLng(locationData['lat'], locationData['lng']);
//         _addMarkers(_center!);
//       });
//     } catch (e) {
//       print('Failed to fetch location: $e');
//     }
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   void _addMarkers(LatLng position) {
//     _markers.add(
//       Marker(
//         markerId: MarkerId('Chosen Location'),
//         position: position,
//         infoWindow: InfoWindow(
//           title: 'Chosen Location',
//           snippet: 'Tap to see more',
//           onTap: () {
//             _showMarkerInfo('Chosen Location');
//           },
//         ),
//         icon: BitmapDescriptor.defaultMarker,
//       ),
//     );
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
//     return BlocBuilder<CreateScheduleBloc, CreateScheduleState>(
//       builder: (context, state) {
//         _fetchLocation(state.startLocation);
//         return Center(
//           child: SizedBox(
//             width: 350, // Set the width of the map
//             height: 300, // Set the height of the map
//             child: _center == null
//                 ? Container()
//                 : GoogleMap(
//                     onMapCreated: _onMapCreated,
//                     initialCameraPosition: CameraPosition(
//                       target: _center!,
//                       zoom: 13.0,
//                     ),
//                     markers: _markers,
//                   ),
//           ),
//         );
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:revy/features/create_schedule/bloc/create_schedule_bloc.dart';
// import '../../data/datasources/remote/geocode_data_source.dart';
// import 'package:dio/dio.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? mapController;

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
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
//     return BlocBuilder<CreateScheduleBloc, CreateScheduleState>(
//       builder: (context, state) {
//         final GeocodingApiDataSource dataSource = GeocodingApiDataSource(Dio());
//         Future<Map<String, dynamic>> location = dataSource.geocodeAddress(state.startLocation);
//         final LatLng _center = const LatLng(location["lat"], location["long"]);

//         final Set<Marker> _markers = {};
//         _markers.add(
//           Marker(
//             markerId: MarkerId("Chosen Location"),
//             position: const LatLng(37.7749, -122.4194),
//             infoWindow: InfoWindow(
//               title: "Chosen location",
//               snippet: 'Tap to see more',
//               onTap: () {
//                 _showMarkerInfo("Chosen location");
//               },
//             ),
//             icon: BitmapDescriptor.defaultMarker,
//           ),
//       );
//         return Center(
//           child: SizedBox(
//             width: 350, // Set the width of the map
//             height: 300, // Set the height of the map
//             child: GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: _center,
//                 zoom: 4.0,
//               ),
//               markers: _markers,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


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
