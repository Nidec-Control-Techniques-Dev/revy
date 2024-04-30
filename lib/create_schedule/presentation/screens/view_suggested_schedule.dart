import 'package:flutter/material.dart';

class SuggestedSchedScreen extends StatelessWidget {
  
  const SuggestedSchedScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Schedule"),
      ),
      body: const Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Text(
              "Here’s your suggested schedule and clients",
              style: TextStyle(fontSize: 35),
            ),
          ],
        )
        
        

      ),
    );
  }
}
