import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key); // Corrected constructor

  @override
  Widget build(BuildContext context) {
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
                "100%", // Assuming full completion
                style: GoogleFonts.anton(
                  fontWeight: FontWeight.bold,
                  fontSize: 55,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: LinearPercentIndicator(
                  lineHeight: 20,
                  percent: 60 / 100,
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
                  progressColor: Color.fromARGB(255, 236, 175, 83),
                  barRadius: Radius.circular(8),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}








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
