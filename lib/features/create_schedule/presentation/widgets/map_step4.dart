import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:revy/features/create_schedule/bloc/schedule_bloc.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng? _center;
  Set<Marker> _markers = {};

  void _fetchLocation(List<dynamic> latitudeList, List<dynamic> longitudeList) async {
    try {
      // Calculate the center of all coordinates
      double sumLat = latitudeList.reduce((a, b) => a + b);
      double sumLong = longitudeList.reduce((a, b) => a + b);
      double centerLat = sumLat / latitudeList.length;
      double centerLong = sumLong / longitudeList.length;

      setState(() {
        _center = LatLng(centerLat, centerLong);
        _addMarkers(latitudeList, longitudeList);
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

  void _addMarkers(List<dynamic> latitudeList, List<dynamic> longitudeList) {
    _markers.clear(); // Clear existing markers

    for (int i = 0; i < latitudeList.length; i++) {
      LatLng position = LatLng(latitudeList[i], longitudeList[i]);
      _markers.add(
        Marker(
          markerId: MarkerId('Location $i'),
          position: position,
          infoWindow: InfoWindow(
            title: 'Location $i',
            snippet: 'Tap to see more',
            onTap: () {
              _showMarkerInfo('Location $i');
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
    print("Building MapScreen with center: $_center");
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        if (state is ScheduleLoaded) {
          _fetchLocation(state.latitude, state.longitude);
        }
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


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:revy/features/create_schedule/bloc/schedule_bloc.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? mapController;
//   LatLng? _center;
//   Set<Marker> _markers = {};

//   @override
//   void didUpdateWidget(MapScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     final state = context.read<ScheduleBloc>().state;
//     if (state is ScheduleLoaded) {
//       List<dynamic> latitudeList = state.latitude;
//       List<dynamic> longitudeList = state.longitude;
//       _fetchLocation(latitudeList, longitudeList);
//     }
//   }

//   void _fetchLocation(List<dynamic> latitudeList, List<dynamic> longitudeList) async {
//     try {
//       // Calculate the center of all coordinates
//       print("latitude----------------------------------------");
//       print(latitudeList);
//       print("longitude----------------------------------------");
//       print(longitudeList);
//       double sumLat = latitudeList.reduce((a, b) => a + b);
//       double sumLong = longitudeList.reduce((a, b) => a + b);
//       double centerLat = sumLat / latitudeList.length;
//       double centerLong = sumLong / longitudeList.length;

//       setState(() {
//         _center = LatLng(centerLat, centerLong);
//         _addMarkers(latitudeList, longitudeList);
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

//   void _addMarkers(List<dynamic> latitudeList, List<dynamic> longitudeList) {
//     _markers.clear(); // Clear existing markers

//     for (int i = 0; i < latitudeList.length; i++) {
//       LatLng position = LatLng(latitudeList[i], longitudeList[i]);
//       _markers.add(
//         Marker(
//           markerId: MarkerId('Location $i'),
//           position: position,
//           infoWindow: InfoWindow(
//             title: 'Location $i',
//             snippet: 'Tap to see more',
//             onTap: () {
//               _showMarkerInfo('Location $i');
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
//     print("Building MapScreen with center: $_center");
//     return BlocBuilder<ScheduleBloc, ScheduleState>(
//       builder: (context, state) {
//         return LayoutBuilder(
//           builder: (context, constraints) {
//             return Center(
//               child: SizedBox(
//                 width: constraints.maxWidth, // Use the available width
//                 height: 300, // Set the height of the map
//                 child: _center == null
//                     ? Container()
//                     : GoogleMap(
//                         onMapCreated: _onMapCreated,
//                         initialCameraPosition: CameraPosition(
//                           target: _center!,
//                           zoom: 13.0,
//                         ),
//                         markers: _markers,
//                       ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:revy/features/create_schedule/bloc/schedule_bloc.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? mapController;
//   LatLng? _center;
//   Set<Marker> _markers = {};

//   @override
//   void didUpdateWidget(MapScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     final state = context.read<ScheduleBloc>().state;
//     if (state is ScheduleLoaded) {
//       List<dynamic> latitudeList = state.latitude;
//       List<dynamic> longitudeList = state.longitude;
//       _fetchLocation(latitudeList, longitudeList);
//     }
//   }

//   void _fetchLocation(List<dynamic> latitudeList, List<dynamic> longitudeList) async {
//     try {
//       // Calculate the center of all coordinates
//       print("latitude----------------------------------------");
//       print(latitudeList);
//       print("longitude----------------------------------------");
//       print(longitudeList);
//       double sumLat = latitudeList.reduce((a, b) => a + b);
//       double sumLong = longitudeList.reduce((a, b) => a + b);
//       double centerLat = sumLat / latitudeList.length;
//       double centerLong = sumLong / longitudeList.length;

//       setState(() {
//         _center = LatLng(centerLat, centerLong);
//         _addMarkers(latitudeList, longitudeList);
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

//   void _addMarkers(List<dynamic> latitudeList, List<dynamic> longitudeList) {
//     _markers.clear(); // Clear existing markers

//     for (int i = 0; i < latitudeList.length; i++) {
//       LatLng position = LatLng(latitudeList[i], longitudeList[i]);
//       _markers.add(
//         Marker(
//           markerId: MarkerId('Location $i'),
//           position: position,
//           infoWindow: InfoWindow(
//             title: 'Location $i',
//             snippet: 'Tap to see more',
//             onTap: () {
//               _showMarkerInfo('Location $i');
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
//     print("Building MapScreen with center: $_center");
//     return BlocBuilder<ScheduleBloc, ScheduleState>(
//       builder: (context, state) {
//         return LayoutBuilder(
//           builder: (context, constraints) {
//             return Center(
//               child: SizedBox(
//                 width: constraints.maxWidth, // Use the available width
//                 height: 300, // Set the height of the map
//                 child: _center == null
//                     ? Container()
//                     : GoogleMap(
//                         onMapCreated: _onMapCreated,
//                         initialCameraPosition: CameraPosition(
//                           target: _center!,
//                           zoom: 5.0,
//                         ),
//                         markers: _markers,
//                       ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }


// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:revy/features/create_schedule/bloc/schedule_bloc.dart';

// // class MapScreen extends StatefulWidget {
// //   const MapScreen({super.key});

// //   @override
// //   _MapScreenState createState() => _MapScreenState();
// // }

// // class _MapScreenState extends State<MapScreen> {
// //   GoogleMapController? mapController;
// //   LatLng? _center;
// //   Set<Marker> _markers = {};

// //   @override
// //   void didUpdateWidget(MapScreen oldWidget) {
// //     super.didUpdateWidget(oldWidget);
// //     final state = context.read<ScheduleBloc>().state;
// //     if (state is ScheduleLoaded) {
// //       List<dynamic> latitudeList = state.latitude;
// //       List<dynamic> longitudeList = state.longitude;
// //       List<dynamic> availableCompanies = state.availableCompanies;
// //       List<dynamic> companyAddresses = state.companyAddresses;
// //       _fetchLocation(latitudeList, longitudeList, availableCompanies, companyAddresses);
// //     }
// //   }

// //   void _fetchLocation(List<dynamic> latitudeList,
// //   List<dynamic> longitudeList, 
// //   List<dynamic> availableCompanies,
// //   List<dynamic> companyAddresses
// //   ) async {
// //     try {
// //       // Calculate the center of all coordinates
// //       double sumLat = latitudeList.reduce((a, b) => a + b);
// //       double sumLong = longitudeList.reduce((a, b) => a + b);
// //       double centerLat = sumLat / latitudeList.length;
// //       double centerLong = sumLong / longitudeList.length;

// //       setState(() {
// //         _center = LatLng(centerLat, centerLong);
// //         _addMarkers(latitudeList, longitudeList, availableCompanies, companyAddresses);
// //       });

// //       // Animate the camera to the new center
// //       mapController?.animateCamera(
// //         CameraUpdate.newLatLng(_center!),
// //       );
// //     } catch (e) {
// //       print('Failed to fetch location: $e');
// //     }
// //   }

// //   void _onMapCreated(GoogleMapController controller) {
// //     mapController = controller;
// //   }

// //   void _addMarkers(List<dynamic> latitudeList,
// //   List<dynamic> longitudeList,
// //   List<dynamic> availableCompanies,
// //   List<dynamic> companyAddresses) {
// //     _markers.clear(); // Clear existing markers

// //     for (int i = 0; i < latitudeList.length; i++) {
// //       LatLng position = LatLng(latitudeList[i], longitudeList[i]);
// //       _markers.add(
// //         Marker(
// //           markerId: MarkerId('Location $i'),
// //           position: position,
// //           infoWindow: InfoWindow(
// //             title: availableCompanies[i],
// //             snippet: 'Tap to see address',
// //             onTap: () {
// //               _showMarkerInfo(companyAddresses[i]);
// //             },
// //           ),
// //           icon: BitmapDescriptor.defaultMarker,
// //         ),
// //       );
// //     }
// //   }

// //   void _showMarkerInfo(String title) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text(title),
// //           content: Text(title),
// //           actions: <Widget>[
// //             TextButton(
// //               child: const Text('Close'),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<ScheduleBloc, ScheduleState>(
// //       builder: (context, state) {
// //         return Center(
// //           child: SizedBox(
// //             width: 250, // Set the width of the map
// //             height: 300, // Set the height of the map
// //             child: _center == null
// //                 ? Container()
// //                 : GoogleMap(
// //                     onMapCreated: _onMapCreated,
// //                     initialCameraPosition: CameraPosition(
// //                       target: _center!,
// //                       zoom: 8,
// //                     ),
// //                     markers: _markers,
// //                   ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }


// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:revy/features/create_schedule/bloc/schedule_bloc.dart';

// // class MapScreen extends StatefulWidget {
// //   const MapScreen({super.key});

// //   @override
// //   _MapScreenState createState() => _MapScreenState();
// // }

// // class _MapScreenState extends State<MapScreen> {
// //   GoogleMapController? mapController;
// //   LatLng? _center;
// //   Set<Marker> _markers = {};

// //   @override
// //   void didUpdateWidget(MapScreen oldWidget) {
// //     super.didUpdateWidget(oldWidget);
// //     final state = context.read<ScheduleBloc>().state;
// //     if (state is ScheduleLoaded) {
// //       List<dynamic> latitudeList = state.latitude;
// //       List<dynamic> longitudeList = state.longitude;
// //       _fetchLocation(latitudeList, longitudeList);
// //     }
// //   }

// //   void _fetchLocation(List<dynamic> latitudeList, List<dynamic> longitudeList) async {
// //     try {
// //       // Calculate the center of all coordinates
// //       print("latitude----------------------------------------");

// //       print(latitudeList);
// //       print("longitude----------------------------------------");
// //       print(longitudeList);
// //       double sumLat = latitudeList.reduce((a, b) => a + b);
// //       double sumLong = longitudeList.reduce((a, b) => a + b);
// //       double centerLat = sumLat / latitudeList.length;
// //       double centerLong = sumLong / longitudeList.length;

// //       setState(() {
// //         _center = LatLng(centerLat, centerLong);
// //         _addMarkers(latitudeList, longitudeList);
// //       });

// //       // Animate the camera to the new center
// //       mapController?.animateCamera(
// //         CameraUpdate.newLatLng(_center!),
// //       );
// //     } catch (e) {
// //       print('Failed to fetch location: $e');
// //     }
// //   }

// //   void _onMapCreated(GoogleMapController controller) {
// //     mapController = controller;
// //   }

// //   void _addMarkers(List<dynamic> latitudeList, List<dynamic> longitudeList) {
// //     _markers.clear(); // Clear existing markers

// //     for (int i = 0; i < latitudeList.length; i++) {
// //       LatLng position = LatLng(latitudeList[i], longitudeList[i]);
// //       _markers.add(
// //         Marker(
// //           markerId: MarkerId('Location $i'),
// //           position: position,
// //           infoWindow: InfoWindow(
// //             title: 'Location $i',
// //             snippet: 'Tap to see more',
// //             onTap: () {
// //               _showMarkerInfo('Location $i');
// //             },
// //           ),
// //           icon: BitmapDescriptor.defaultMarker,
// //         ),
// //       );
// //     }
// //   }

// //   void _showMarkerInfo(String title) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text(title),
// //           content: Text('This is $title.'),
// //           actions: <Widget>[
// //             TextButton(
// //               child: const Text('Close'),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<ScheduleBloc, ScheduleState>(
// //       builder: (context, state) {
// //         return Center(
// //           child: SizedBox(
// //             width: 350, // Set the width of the map
// //             height: 300, // Set the height of the map
// //             child: _center == null
// //                 ? Container()
// //                 : GoogleMap(
// //                     onMapCreated: _onMapCreated,
// //                     initialCameraPosition: CameraPosition(
// //                       target: _center!,
// //                       zoom: 13.0,
// //                     ),
// //                     markers: _markers,
// //                   ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }


// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:revy/features/create_schedule/bloc/schedule_bloc.dart';
// // import '../../data/datasources/remote/geocode_data_source.dart';
// // import 'package:dio/dio.dart';

// // class MapScreen extends StatefulWidget {
// //   const MapScreen({super.key});

// //   @override
// //   _MapScreenState createState() => _MapScreenState();
// // }

// // class _MapScreenState extends State<MapScreen> {
// //   GoogleMapController? mapController;
// //   LatLng? _center;
// //   Set<Marker> _markers = {};

// //   @override
// //   void didUpdateWidget(MapScreen oldWidget) {
// //     super.didUpdateWidget(oldWidget);
// //     final state = context.read<ScheduleBloc>().state;
// //     if (state is ScheduleLoaded){
// //       List<dynamic> latitudeList = state.latitude;
// //       List<dynamic> longigtudeList = state.longitude;
// //       _fetchLocation(latitudeList, longigtudeList);
// //     } 
// //   }

// //   void _fetchLocation(List<dynamic> latitudeList, List<dynamic> longigtudeList) async {
// //     try {
// //       double sumLat = latitudeList.reduce((a, b)=> a +b);
// //       double sumLong = latitudeList.reduce((a, b)=> a +b);
// //       double centerLat = sumLat / latitudeList.length;
// //       double centerLong = sumLong / longigtudeList.length;
// //       setState(() {
// //         _center = LatLng(centerLat, centerLong);
// //         _addMarkers(latitudeList, longigtudeList);
// //       });
// //       // Animate the camera to the new center
// //       mapController?.animateCamera(
// //         CameraUpdate.newLatLng(_center!),
// //       );
// //     } catch (e) {
// //       print('Failed to fetch location: $e');
// //     }
// //   }

// //   void _onMapCreated(GoogleMapController controller) {
// //     mapController = controller;
// //   }

// //   void _addMarkers(List<dynamic> latitudeList, List<dynamic> longitudeList) {
// //       _markers.clear(); // Clear existing markers

// //       for (int i = 0; i < latitudeList.length; i++) {
// //         LatLng position = LatLng(latitudeList[i], longitudeList[i]);
// //         _markers.add(
// //           Marker(
// //             markerId: MarkerId('Location $i'),
// //             position: position,
// //             infoWindow: InfoWindow(
// //               title: 'Location $i',
// //               snippet: 'Tap to see more',
// //               onTap: () {
// //                 _showMarkerInfo('Location $i');
// //               },
// //             ),
// //             icon: BitmapDescriptor.defaultMarker,
// //           ),
// //         );
// //       }
// //     }

// //   void _showMarkerInfo(String title) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text(title),
// //           content: Text('This is $title.'),
// //           actions: <Widget>[
// //             TextButton(
// //               child: const Text('Close'),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<ScheduleBloc, ScheduleState>(
// //       builder: (context, state) {
// //         return Center(
// //           child: SizedBox(
// //             width: 350, // Set the width of the map
// //             height: 300, // Set the height of the map
// //             child: _center == null
// //                 ? Container()
// //                 : GoogleMap(
// //                     onMapCreated: _onMapCreated,
// //                     initialCameraPosition: CameraPosition(
// //                       target: _center!,
// //                       zoom: 13.0,
// //                     ),
// //                     markers: _markers,
// //                   ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
