import 'package:flutter/material.dart';
import '../../../../../main.dart';
import '../widgets/accordion_widget.dart';

class SuggestedSchedWidget extends StatelessWidget {
  const SuggestedSchedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            height: 200.0,
          ),
        ],
      ),
    );
  }
}
