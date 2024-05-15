import 'package:flutter/material.dart';
import 'select_sched_date.dart';
import '../widgets/google_maps_widget.dart';
import '../widgets/searchbar_debounce_widget.dart';

class StartLocScreen extends StatelessWidget {
  
  const StartLocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Create Schedule"),
      ),
      body: Align(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Area of Chosen Address",
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10.0
            ),
            // const DebouncedSearchBar(),
            const SizedBox(
              height: 10.0
            ),
            const Expanded(
              // Use Expanded to fill the remaining space with the map
              child: MapSample(), // Assuming MapSample is the name of your map widget
            ),
            SizedBox(
              width: double.infinity,
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed:  () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SelectSchedDateScreen()),
                  );
                },
                child: const Text('Select Schedule Dates'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
