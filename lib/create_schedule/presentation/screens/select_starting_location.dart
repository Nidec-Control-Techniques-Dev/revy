import 'package:flutter/material.dart';
import 'select_starting_date.dart';
import '../widgets/google_maps_widget.dart';

class StartLocScreen extends StatelessWidget {
  
  const StartLocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Schedule"),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Where will you be coming from?",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const Expanded(
              // Use Expanded to fill the remaining space with the map
              child: MapSample(), // Assuming MapSample is the name of your map widget
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SelectSchedDateScreen()),
                );
              },
              child: const Text('Choose Schedule dates'),
            ),
          ],
        )
        
        

      ),
    );
  }
}
