import 'package:flutter/material.dart';
import 'select_client_preferences.dart';

class SelectSchedDateScreen extends StatelessWidget {
  
  const SelectSchedDateScreen({super.key});
  
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
            const Text(
              "Which date/s do you want to create a schedule?",
              style: TextStyle(fontSize: 35),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClientConfigScreen()),
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
