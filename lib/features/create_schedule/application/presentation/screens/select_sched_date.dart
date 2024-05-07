import 'package:flutter/material.dart';
import 'select_client_preferences.dart';
import '../widgets/date_picker.dart';
import '../widgets/date_picker_v2.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
// "Which date/s do you want to create a schedule?"

class SelectSchedDateScreen extends StatelessWidget {
  
  const SelectSchedDateScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Schedule"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "For which date/s do you want to create a schedule?",
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
      
          // const Expanded(
          //   // Use Expanded to fill the remaining space with the map
          //   child: DatePickerExample(), // Assuming MapSample is the name of your map widget
          // ),
          // const Expanded(
          //   // Use Expanded to fill the remaining space with the map
          //   child: DatePickerExample(), // Assuming MapSample is the name of your map widget
          // ),
          const Expanded(
            // Use Expanded to fill the remaining space with the map
            child: DatePickerCupertino(), // Assuming MapSample is the name of your map widget
          ),
      
          Container(
            width: double.infinity,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClientConfigScreen()),
                );
              },
              child: const Text('Choose Client Preferences'),
            ),
          ),
        ],
      ),
    );
  }
}
