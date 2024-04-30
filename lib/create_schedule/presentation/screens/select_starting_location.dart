import 'package:flutter/material.dart';
import 'select_starting_date.dart';

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
            const Text(
              "Where will you be coming from?",
              style: TextStyle(fontSize: 35),
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
