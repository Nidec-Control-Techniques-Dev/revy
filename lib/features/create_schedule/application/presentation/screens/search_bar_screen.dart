import 'package:flutter/material.dart';
import 'select_starting_location.dart';
import '../widgets/search_bar.dart';

class SearchBarScreen extends StatelessWidget {
  const SearchBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Create Schedule"),
      ),
      body: Stack(
        children: [
          const SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.only(bottom: 60.0), // Add padding to avoid overlap
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text widget
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Where will you be coming from? Search your address",
                      style: TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Search Bar widget with Places API
                  SizedBox(
                    height: 500,
                    child: PlacesSearchBar(),
                  ),
                ],
              ),
            ),
          ),
          // Button for next stage of create schedule
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.all(10.0), // Padding for aesthetic spacing
              child: Row(
                children: [
                  Expanded(
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StartLocScreen()),
                        );
                      },
                      label: const Text('Select Starting Location'),
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
