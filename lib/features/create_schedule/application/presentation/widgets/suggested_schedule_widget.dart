import 'package:flutter/material.dart';
import 'accordion_widget.dart';

class SuggestedSchedWidget extends StatelessWidget {
  const SuggestedSchedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Here’s your suggested schedule",
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          AccordionPage(),
          SizedBox(
            height: 200.0,
          ),
        ],
      ),
    );
  }
}
