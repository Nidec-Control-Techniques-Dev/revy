import 'package:flutter/material.dart';
import 'view_suggested_schedule.dart';
import '../widgets/multiselect_widget.dart';

class ClientConfigScreen extends StatelessWidget {
  
  const ClientConfigScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Schedule"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "What are your client preferences?",
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              child: SizedBox(
                child: Expanded(
                  // Use Expanded to fill the remaining space with the map
                  child: MultiSelectWidget(), // Assuming MapSample is the name of your map widget
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SuggestedSchedScreen()),
                  );
                },
                child: const Text('Generate Schedule'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
