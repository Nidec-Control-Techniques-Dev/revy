import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CurrentDate extends StatelessWidget {
  const CurrentDate({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    DateTime now = DateTime.now();
    // Format the date and time using intl
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(width:1.0),
        ),
        child: Text(
          formattedDate,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class LastSevenDays extends StatelessWidget {
  const LastSevenDays({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    DateTime now = DateTime.now();
    // Calculate the start date (7 days ago)
    DateTime startDate = now.subtract(const Duration(days: 6));

    // Format the date as needed
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedStartDate = dateFormat.format(startDate);
    String formattedEndDate = dateFormat.format(now);


    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(width:1.0),
        ),
        child: Text(
          '$formattedStartDate - $formattedEndDate',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class LastThirtyDays extends StatelessWidget {
  const LastThirtyDays({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current date and time
    DateTime now = DateTime.now();
    // Calculate the start date (7 days ago)
    DateTime startDate = now.subtract(const Duration(days: 29));

    // Format the date as needed
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedStartDate = dateFormat.format(startDate);
    String formattedEndDate = dateFormat.format(now);


    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(width:1.0),
        ),
        child: Text(
          '$formattedStartDate - $formattedEndDate',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}