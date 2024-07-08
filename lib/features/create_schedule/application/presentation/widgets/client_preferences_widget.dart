import 'package:flutter/material.dart';
import 'multiselect_widget.dart';

class ClientConfigWidget extends StatelessWidget {
  const ClientConfigWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "What are your client preferences?",
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            child: MultiSelectWidget(), // Assuming MultiSelectWidget is the name of your widget
          ),
        ],
      ),
    );
  }
}
