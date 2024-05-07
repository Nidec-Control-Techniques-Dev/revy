import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class DebouncedSearchBar extends StatefulWidget {
  @override
  _DebouncedSearchBarState createState() => _DebouncedSearchBarState();
}

class _DebouncedSearchBarState extends State<DebouncedSearchBar> {
  final _searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(30.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,  // Removes default underline
          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2.0),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2.0),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onChanged: (value) {
          _debouncer.run(() {
            // Perform the search operation
          });
        },
      ),
    );
  }
}

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Debouncer {
//   final int milliseconds;
//   VoidCallback? action;
//   Timer? _timer;

//   Debouncer({required this.milliseconds});

//   run(VoidCallback action) {
//     _timer?.cancel();
//     _timer = Timer(Duration(milliseconds: milliseconds), action);
//   }
// }

// class DebouncedSearchBar extends StatefulWidget {
//   @override
//   _DebouncedSearchBarState createState() => _DebouncedSearchBarState();
// }

// class _DebouncedSearchBarState extends State<DebouncedSearchBar> {
//   final _searchController = TextEditingController();
//   final _debouncer = Debouncer(milliseconds: 500);
//   List<String> _searchResults = [];

//   void performSearch(String query) async {
//     var response = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=geocode&key=YOUR_API_KEY&maxresults=5'));
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       setState(() {
//         _searchResults = data['predictions']; // Assuming the API returns a JSON object with a 'predictions' field
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Debounced Search Example'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Material(
//               elevation: 4.0,
//               borderRadius: BorderRadius.circular(30.0),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   hintText: 'Search',
//                   prefixIcon: Icon(Icons.search),
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(vertical: 15.0),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.green, width: 2.0),
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.green, width: 2.0),
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                 ),
//                 onChanged: (value) {
//                   _debouncer.run(() {
//                     performSearch(value);
//                   });
//                 },
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _searchResults.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_searchResults[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
