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

      // Return the UI based on the calculated percentValue
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Text(
                  "$percentValue% Visited", // Display calculated percentage
                  style: GoogleFonts.anton(
                    fontWeight: FontWeight.bold,
                    fontSize: 55,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
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



// class ProgressBar extends StatelessWidget {
//   const ProgressBar({super.key}); // Corrected constructor

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ReadProgressBloc, ProgressTrackerState>(
//         builder: (context, state) {
//       if (state is DataError) {
//         return Center(child: Text('Error: ${state.message}'));
//       }
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
//                   "100%", // Assuming full completion
//                   style: GoogleFonts.anton(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 55,
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   child: LinearPercentIndicator(
//                     lineHeight: 20,
//                     percent: 60 / 100,
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
//                     progressColor: const Color.fromARGB(255, 236, 175, 83),
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

// class ProgressBar extends StatelessWidget {
//   final int totalClients;
//   final int completedClients;

//   const ProgressBar({
//     Key? key,
//     required this.totalClients,
//     required this.completedClients,
//   }) : super(key: key);

//   double get percentage {
//     // Safely calculate the percentage, handling cases where totalClients or completedClients are zero
//     if (totalClients == 0 || completedClients == 0) {
//       return 0; // Avoid division by zero
//     } else {
//       return completedClients / totalClients * 100;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(height: 20),
//               Text(
//                 "${percentage.toStringAsFixed(0)}%",
//                 style: GoogleFonts.anton(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 55,
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 child: LinearPercentIndicator(
//                   lineHeight: 20,
//                   percent: percentage / 100,
//                   animation: true,
//                   animationDuration: 2000,
//                   leading: const Text(
//                     '0%',
//                     style: TextStyle(
//                       fontSize: 20,
//                     ),
//                   ),
//                   trailing: const Text(
//                     '100%',
//                     style: TextStyle(
//                         fontSize: 20, color: Color.fromARGB(255, 11, 12, 11)),
//                   ),
//                   progressColor: const Color.fromARGB(255, 236, 175, 83),
//                   barRadius: const Radius.circular(8),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'progress_bloc.dart'; // Import your BLoC

// class ProgressBar extends StatelessWidget {
//   const ProgressBar({Key? key}) : super(key: key); // Corrected constructor

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(height: 20),
//               Text(
//                 "100%", // Assuming full completion
//                 style: GoogleFonts.anton(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 55,
//                 ),
//               ),
//               BlocBuilder<ProgressBloc, ProgressState>(
//                 builder: (context, state) {
//                   if (state is ProgressInitial) {
//                     return CircularProgressIndicator(); // Show loading indicator initially
//                   } else if (state is ProgressUpdated) {
//                     return Container(
//                       padding: EdgeInsets.all(20),
//                       child: LinearPercentIndicator(
//                         lineHeight: 20,
//                         percent: state.progress / 100,
//                         animation: true,
//                         animationDuration: 2000,
//                         leading: const Text(
//                           '0%',
//                           style: TextStyle(
//                             fontSize: 20,
//                           ),
//                         ),
//                         trailing: const Text(
//                           '100%',
//                           style: TextStyle(
//                               fontSize: 20, color: Color.fromARGB(255, 11, 12, 11)),
//                         ),
//                         progressColor: Color.fromARGB(255, 236, 175, 83),
//                         barRadius: Radius.circular(8),
//                       ),
//                     );
//                   } else {
//                     return SizedBox.shrink(); // Handle other states if needed
//                   }
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }





  //   return Center(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         const SizedBox(height: 20),
  //         Text(
  //           "100%", // Assuming full completion
  //           style: GoogleFonts.anton(
  //             fontWeight: FontWeight.bold,
  //             fontSize: 55,
  //           ),
  //         ),
  //         Container(
  //           padding: EdgeInsets.all(20),
  //           child: LinearPercentIndicator(
  //               width: 180.0,
  //               lineHeight: 20,
  //               percent: 60 / 100,
  //               animation: true,
  //               animationDuration: 2000,
  //               leading: const Text(
  //                 '0%',
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                 ),
  //               ),
  //               trailing: const Text(
  //                 '100%',
  //                 style: TextStyle(
  //                     fontSize: 20, color: Color.fromARGB(255, 11, 12, 11)),
  //               ),
  //               progressColor: Color.fromARGB(255, 236, 175, 83),
  //               barRadius: Radius.circular(8)),
  //         )
  //       ],
  //     ),
  //   );
  // }
// }

        // Container(
          //   decoration: BoxDecoration(
          //     border: Border.all(
          //       color: Colors.black, // Border color
          //       width: 2, // Border width
          //     ),
          //   ),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(15), // Radius of the corners
          //     child: LinearPercentIndicator(
          //       lineHeight: 20,
          //       percent: 1,
          //       backgroundColor: Colors.grey[200],
          //       progressColor: Color.fromARGB(255, 236, 175, 83),
          //     ),
          //   ),
          // ),

// import 'package:flutter/material.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProgressBar extends StatelessWidget {
//   const ProgressBar({Key? key}) : super(key: key); // Corrected constructor

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 20),
//           Text(
//             "100%", // Assuming full completion
//             style: GoogleFonts.anton(
//               fontWeight: FontWeight.bold,
//               fontSize: 55,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 10.0), // Adjusted padding
//             child: LinearPercentIndicator(
//               lineHeight: 20, // Line height (thickness)
//               percent: 1, // Full completion
//               backgroundColor: Colors.grey[200], // Background color
//               progressColor:
//                   Color.fromARGB(255, 236, 175, 83), // Progress color
//               // No need for startAngle or endAngle unless you have a specific design requirement
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';

// class ProgressBar extends StatelessWidget {
//   const ProgressBar({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 20),
//           Text(
//             "70%",
//             style: GoogleFonts.anton(
//               fontWeight: FontWeight.bold,
//               fontSize: 35,
//             ),
//           ),
//           const SizedBox(height: 20),
//           LinearPercentIndicator(
//             lineHeight: 15, // Set line height (thickness)
//             width: MediaQuery.of(context).size.width -
//                 40, // Adjust width based on screen size
//             percent: 0.7,
//             backgroundColor: Colors.grey[200], // Background color
//             progressColor: Color.fromARGB(255, 236, 175, 83), // Progress color
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProgressBar extends StatelessWidget {
//   const ProgressBar({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Transform.scale(
//           scale: 2.0, // Scale factor of 2.0
//           child: Text(
//             "Sales Progress",
//             style: GoogleFonts.rubik(
//               fontWeight:
//                   FontWeight.bold, // or FontWeight.w700 for a bolder appearance
//             ),
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               CircularPercentIndicator(
//                 radius: 150.0,
//                 lineWidth: 25.0,
//                 animation: true,
//                 percent: 0.7,
//                 center: Transform.scale(
//                   scale: 5.5, // Scale factor of 2.0
//                   child: Text(
//                     "70%",
//                     style: GoogleFonts.roboto(
//                       fontWeight: FontWeight
//                           .bold, // or FontWeight.w700 for a bolder appearance
//                     ),
//                   ),
//                 ),
//                 circularStrokeCap: CircularStrokeCap.square,
//                 progressColor: Colors.greenAccent,
//                 backgroundColor: const Color.fromARGB(255, 92, 91, 91),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//             ]),
//       ),
//     );
//   }
// }
