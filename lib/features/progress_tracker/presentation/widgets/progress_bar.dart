import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadProgressBloc, ProgressTrackerState>(
        builder: (context, state) {
      if (state is DataError) {
        return Center(child: Text('Error: ${state.message}'));
      }
      
      final status = state.status;

      int numVisited = 0;
      int numTotal = 0;

      for (var item in status ?? []) {
        if (item == 'visited') {
          numVisited += 1; 
        }
        numTotal += 1;
      }
      double percentValue = numTotal > 0 ? (numVisited / numTotal) * 100 : 0;

      // Round the percentValue to two decimal places
      String roundedPercentValue = percentValue.toStringAsFixed(2);

      // Return the UI based on the calculated percentValue
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5),
                Text(
                  "$roundedPercentValue% Visited", // Display rounded percentage
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: LinearPercentIndicator(
                    lineHeight: 20,
                    percent: percentValue.isFinite
                        ? percentValue / 100
                        : 0, // Ensure percentValue is a finite number
                    animation: true,
                    animationDuration: 2000,
                    leading: const Text(
                      '0%',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    trailing: const Text(
                      '100%',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 11, 12, 11)),
                    ),
                    // progressColor: const Color.fromARGB(255, 236, 175, 83),
                    progressColor: Colors.green,
                    barRadius: const Radius.circular(8),
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:revy/features/progress_tracker/bloc/read_progress_bloc.dart';

// class ProgressBar extends StatelessWidget {
//   const ProgressBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ReadProgressBloc, ProgressTrackerState>(
//         builder: (context, state) {
//       if (state is DataError) {
//         return Center(child: Text('Error: ${state.message}'));
//       }
      
//       final status = state.status;

//       int numVisited = 0;
//       int numTotal = 0;


//       for (var item in status ?? []) {
//         if (item == 'visited') {
//           numVisited += 1; 
//         }
//         numTotal += 1;
//       }
//       double percentValue = numTotal > 0 ? (numVisited / numTotal) * 100 : 0;

//       // Return the UI based on the calculated percentValue
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(height: 20),
//                 Text(
//                   "$percentValue% Visited", // Display calculated percentage
//                   style: GoogleFonts.anton(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 55,
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   child: LinearPercentIndicator(
//                     lineHeight: 20,
//                     percent: percentValue.isFinite
//                         ? percentValue / 100
//                         : 0, // Ensure percentValue is a finite number
//                     animation: true,
//                     animationDuration: 2000,
//                     leading: const Text(
//                       '0%',
//                       style: TextStyle(
//                         fontSize: 20,
//                       ),
//                     ),
//                     trailing: const Text(
//                       '100%',
//                       style: TextStyle(
//                           fontSize: 20, color: Color.fromARGB(255, 11, 12, 11)),
//                     ),
//                     // progressColor: const Color.fromARGB(255, 236, 175, 83),
//                     progressColor: Colors.green,
//                     barRadius: const Radius.circular(8),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       );
//     });
//   }
// }

