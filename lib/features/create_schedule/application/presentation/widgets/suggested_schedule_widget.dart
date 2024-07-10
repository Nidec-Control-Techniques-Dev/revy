import 'package:flutter/material.dart';
import 'accordion_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/upload_schedule_bloc.dart';
import '../../../bloc/schedule_bloc.dart';

class SuggestedSchedWidget extends StatelessWidget {
  const SuggestedSchedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        if (state is ScheduleLoaded){
          return BlocBuilder<UploadScheduleBloc, UploadScheduleState>(
            builder: (context, state) {
              if (state is ScheduleIsSaving) {
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                    // return AlertDialog(
                    //   title: const Text('Schedule Ready'),
                    //   content: const Text('Your suggested schedule is being prepared. '),
                    //   actions: <Widget>[
                    //     TextButton(
                    //       child: const Text('OK'),
                    //       onPressed: () {
                    //         Navigator.of(context).pop();
                    //         WidgetsBinding.instance.addPostFrameCallback((_) {
                    //           showDialog(
                    //             context: context,
                    //             builder: (BuildContext context) {
                    //               return AlertDialog(
                    //                 title: const Text("Don't like your schedule?"),
                    //                 content: const Text(
                    //                   'You can generate another schedule with a different set of clients selected '
                    //                   'by letting time pass or choosing a different set of configurations'),

                    //                 actions: <Widget>[
                    //                   TextButton(
                    //                     child: const Text('OK'),
                    //                     onPressed: () {
                    //                       Navigator.of(context).pop(); // Close the dialog
                    //                       WidgetsBinding.instance.addPostFrameCallback((_) {
                    //                         showDialog(
                    //                           context: context,
                    //                           builder: (BuildContext context) {
                    //                             return AlertDialog(
                    //                               title: const Text('Have an issue with the schedule?'),
                    //                               content: const Text(
                    //                                 'Please report an issue if the information given on the clients are invalid '
                    //                               ),
                    //                               actions: <Widget>[
                    //                                 TextButton(
                    //                                   child: const Text('OK'),
                    //                                   onPressed: () {
                    //                                     Navigator.of(context).pop(); // Close the dialog
                    //                                   },
                    //                                 ),
                    //                               ],
                    //                             );
                    //                           },
                    //                         );
                    //                       });
                    //                     },
                    //                   ),
                    //                 ],
                    //               );
                    //             },
                    //           );
                    //         });// Close the dialog
                    //       },
                    //     ),
                    //   ],
                    // );
                //   },
                // );
                return const Column(
                  children: [
                    Text("Saving Schedule"),
                    // SizedBox(height: 200.0),
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                );
              } else {
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
            },
          );
        }
        else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'accordion_widget.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../bloc/schedule_bloc.dart';
// class SuggestedSchedWidget extends StatelessWidget {
//   const SuggestedSchedWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ScheduleBloc, ScheduleState>(
//       builder: (context, state) {
//         return const SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   "Here’s your suggested schedule",
//                   style: TextStyle(fontSize: 22),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               AccordionPage(),
//               SizedBox(
//                 height: 200.0,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'accordion_widget.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../bloc/create_schedule_bloc.dart';
// // import '../../../bloc/client_config_bloc.dart'; // Import DataBloc

// class SuggestedSchedWidget extends StatelessWidget {
//   const SuggestedSchedWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CreateScheduleBloc, CreateScheduleState>(
//       builder: (context, createScheduleState) {
//         // Assuming createScheduleState is CreateScheduleLoadSuccess and has properties like startLocation, startDate, etc.
//         return const SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   "Here’s your suggested schedule",
//                   style: TextStyle(fontSize: 22),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               // Nested BlocBuilder for DataBloc
//               // BlocBuilder<DataBloc, DataState>(
//               //   builder: (context, dataState) {
//                 // context.read<DataBloc>().add(GenerateSchedule());
//                  AccordionPage(
//                   // startLocation: createScheduleState.startLocation,
//                   // startDate: createScheduleState.startDate,
//                   // endDate: createScheduleState.endDate,
//                   // chosenStates: createScheduleState.chosenStates,
//                   // chosenBusinessModels: createScheduleState.chosenBusinessModels,
//                   // chosenCategories: createScheduleState.chosenCategories
//                 ),
//               //   },
//               // ),

//               SizedBox(
//                 height: 200.0,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }


// // import 'package:flutter/material.dart';
// // import 'accordion_widget.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import '../../../bloc/create_schedule_bloc.dart';

// // class SuggestedSchedWidget extends StatelessWidget {
// //   const SuggestedSchedWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return const SingleChildScrollView(
// //       child: Column(
// //         children: [
// //           Padding(
// //             padding: EdgeInsets.all(8.0),
// //             child: Text(
// //               "Here’s your suggested schedule",
// //               style: TextStyle(fontSize: 22),
// //               textAlign: TextAlign.center,
// //             ),
// //           ),
// //           AccordionPage(),
// //           SizedBox(
// //             height: 200.0,
// //           ),
// //         ],
// //       ),
// //     );

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<CreateScheduleBloc, CreateScheduleState>(
// //       builder: (context, state) {
// //         // Assuming state is CreateScheduleLoadSuccess and has a schedule property
// //         return SingleChildScrollView(
// //           child: Column(
// //             children: [
// //               const Padding(
// //                 padding: EdgeInsets.all(8.0),
// //                 child: Text(
// //                   "Here’s your suggested schedule",
// //                   style: TextStyle(fontSize: 22),
// //                   textAlign: TextAlign.center,
// //                 ),
// //               ),
// //               AccordionPage(
// //                 startLocation: state.startLocation,
// //                 startDate: state.startDate,
// //                 endDate: state.endDate,
// //                 chosenStates: state.chosenStates,
// //                 chosenBusinessModels: state.chosenBusinessModels,
// //                 chosenCategories: state.chosenCategories
// //               ),
// //               const SizedBox(
// //                 height: 200.0,
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
// // }