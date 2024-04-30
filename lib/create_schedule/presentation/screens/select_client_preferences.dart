import 'package:flutter/material.dart';
import 'view_suggested_schedule.dart';

class ClientConfigScreen extends StatelessWidget {
  
  const ClientConfigScreen({super.key});
  
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
              "What are your client preferences?",
              style: TextStyle(fontSize: 35),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SuggestedSchedScreen()),
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
