import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../widgets/date_picker.dart'; 
import 'package:google_fonts/google_fonts.dart';

class ProgressBar extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Transform.scale(
            scale: 2.0, // Scale factor of 2.0
            child: Text(
              "Sales Progress",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.bold, // or FontWeight.w700 for a bolder appearance
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Center(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20, ),
            CircularPercentIndicator(
              radius: 150.0,
              lineWidth: 25.0,
              animation: true,
              percent: 0.7,
              center: Transform.scale(
                scale: 5.5, // Scale factor of 2.0
                child: Text(
                  "70%",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, // or FontWeight.w700 for a bolder appearance
                  ),
                ),
              ),
              circularStrokeCap: CircularStrokeCap.square,
              progressColor: Colors.greenAccent,
              backgroundColor: Color.fromARGB(255, 92, 91, 91),

            ),
            const SizedBox(height: 20, ),

          ]
        ),),
    );
  }
}