import 'package:flutter/material.dart';
import 'select_sched_date.dart';
import '../widgets/google_maps_widget.dart';
import '../widgets/searchbar_debounce_widget.dart';

class StartLocScreen extends StatelessWidget {
  
  const StartLocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Create Schedule"),
      ),
      body: Align(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Where will you be coming from?",
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10.0
            ),
            DebouncedSearchBar(),
            const SizedBox(
              height: 10.0
            ),
            const Expanded(
              // Use Expanded to fill the remaining space with the map
              child: MapSample(), // Assuming MapSample is the name of your map widget
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const SelectSchedDateScreen()),
            //     );
            //   },
            //   child: const Text('Choose Schedule dates'),
            // ),
            // const SizedBox(
            //   height: 20.0
            // ),
            Container(
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
