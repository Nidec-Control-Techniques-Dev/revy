import 'package:flutter/material.dart';
import '../widgets/client_list.dart';
import '../widgets/client_page.dart';
import '../widgets/date_picker.dart';
import '../widgets/progress_bar.dart';

class ProgressTrackerApp extends StatelessWidget {
  const ProgressTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Progress Tracker'),
        ),
        body: SingleChildScrollView( // Use SingleChildScrollView to allow scrolling if the content overflows
          child: Column(
              children: [
                Container(
                    // A fixed-height child.
                    color: const Color(0xffeeee00), // Yellow
                    height: 396.0,
                    alignment: Alignment.center,
                    child: ProgressBar(),
                  ),
                  Container(
                    // A fixed-height child.
                    color: const Color(0xffeeee00), // Yellow
                    height: 220.0,
                    alignment: Alignment.center,
                    child: DatePicker(),
                  ),
                  Container(
                    // A fixed-height child.
                    // color: Color.fromARGB(255, 103, 103, 31), // Yellow
                    height: 400.0,
                    alignment: Alignment.center,
                    child: ClientList(),
                  ),
                // ProgressBar(), // Your ProgressBar widget
                // MainPage(), // Your MainPage widget
              ],
            ),
        ),
      ),
      routes: {
        '/clientlist': (context) => ClientList()
      }
    );
  }
}