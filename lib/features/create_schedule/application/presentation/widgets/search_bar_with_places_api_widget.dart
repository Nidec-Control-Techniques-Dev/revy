import 'package:flutter/material.dart';
import 'search_bar.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: 60.0), // Add padding to avoid overlap
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text widget
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Where will you be coming from?",
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            // Search Bar widget with Places API
            SizedBox(
              height: 450,
              child: PlacesSearchBar(),
            ),
            // Flexible(
            //   child: PlacesSearchBar()
            // )
          ],
        ),
      ),
    );
  }
}
