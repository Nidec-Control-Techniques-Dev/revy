import 'package:flutter/material.dart';

import '../widgets/multiselect_widget.dart';
import 'view_suggested_schedule.dart';

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
            const SizedBox(
              child: SizedBox(
                child: Expanded(
                  // Use Expanded to fill the remaining space with the map
                  child:
                      MultiSelectWidget(), // Assuming MapSample is the name of your map widget
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SuggestedSchedScreen()),
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
