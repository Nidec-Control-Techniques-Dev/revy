import 'package:flutter/material.dart';
import '../../../../../main.dart';
import '../widgets/accordion_widget.dart';

class SuggestedSchedScreen extends StatelessWidget {
  
  const SuggestedSchedScreen({super.key});
  
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
                "Here’s your suggested schedule",
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            const AccordionPage(),
            const SizedBox(
              height: 200.0
            ),
            Container(
              width: double.infinity,
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text('Generate Schedule'),
              ),
            ),
          ],
        )
        
        

      ),
    );
  }
}
