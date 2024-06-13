// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import '../../../../data/datasources/remote/place_api_data_source.dart'; // Adjust the import path as necessary
// import '../../../../domain/utils/place_suggestions.dart'; // Adjust the import path as necessary

// class Debouncer {
//  final int milliseconds;
//  VoidCallback? action;
//  Timer? _timer;

//  Debouncer({required this.milliseconds});

//  run(VoidCallback action) {
//     _timer?.cancel();
//     _timer = Timer(Duration(milliseconds: milliseconds), action);
//  }
// }

// class DebouncedSearchBar extends StatefulWidget {
//  const DebouncedSearchBar({super.key});

//  @override
//  _DebouncedSearchBarState createState() => _DebouncedSearchBarState();
// }

// class _DebouncedSearchBarState extends State<DebouncedSearchBar> {
//  final _searchController = TextEditingController();
//  final _debouncer = Debouncer(milliseconds: 500);
//  List<String> _searchResults = [];
//  final PlaceApiDataSource _dataSource = PlaceApiDataSource(Dio());

//  @override
//  Widget build(BuildContext context) {
//     return Material(
//       elevation: 4.0,
//       borderRadius: BorderRadius.circular(30.0),
//       child: TextField(
//         controller: _searchController,
//         decoration: InputDecoration(
//           hintText: 'Search',
//           prefixIcon: const Icon(Icons.search),
//           border: InputBorder.none, // Removes default underline
//           contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
//           enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.green, width: 2.0),
//             borderRadius: BorderRadius.circular(30.0),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.green, width: 2.0),
//             borderRadius: BorderRadius.circular(30.0),
//           ),
//         ),
//         onChanged: (value) {
//           _debouncer.run(() {
//             _fetchPlaceSuggestions(value);
//           });
//         },
//       ),
//     );
//  }

//  void _fetchPlaceSuggestions(String query) async {
//     if (query.isNotEmpty) {
//       try {
//         String jsonResponse = await _dataSource.fetchPlaceSuggestions(query);
//         List<String> mainTexts = PlaceSuggestions.getMainTexts(jsonResponse);
//         setState(() {
//           _searchResults = mainTexts;
//         });
//       } catch (e) {
//         print('Failed to fetch place suggestions: $e');
//       }
//     }
//  }
// }
