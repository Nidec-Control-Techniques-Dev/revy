// import 'package:flutter/material.dart';
// import '../widgets/accordion_widget.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../bloc/upload_schedule_bloc.dart';
// import '../../bloc/schedule_bloc.dart';
// import '../widgets/map_step4.dart';

// class SuggestedSchedWidget extends StatelessWidget {
//   const SuggestedSchedWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ScheduleBloc, ScheduleState>(
//       builder: (context, state) {
//         if (state is ScheduleLoaded) {
//           return BlocBuilder<UploadScheduleBloc, UploadScheduleState>(
//             builder: (context, state) {
//               if (state is ScheduleIsSaving) {
//                 return const Column(
//                   children: [
//                     Text("Saving Schedule"),
//                     Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   ],
//                 );
//               } else {
//                 return SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 8.0),
//                         child: Text(
//                           "Here’s your suggested schedule",
//                           style: TextStyle(fontSize: 22),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       const MapScreen(),
//                       const AccordionPage(),
//                       const SizedBox(
//                         height: 200.0,
//                       ),
//                     ],
//                   ),
//                 );
//               }
//             },
//           );
//         } else {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../widgets/accordion_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/upload_schedule_bloc.dart';
import '../../bloc/schedule_bloc.dart';

class SuggestedSchedWidget extends StatelessWidget {
  const SuggestedSchedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        if (state is ScheduleLoaded) {
          return BlocBuilder<UploadScheduleBloc, UploadScheduleState>(
            builder: (context, state) {
              if (state is ScheduleIsSaving) {
                return const Column(
                  children: [
                    Text("Saving Schedule"),
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                );
              } else {
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
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import '../widgets/accordion_widget.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../bloc/upload_schedule_bloc.dart';
// import '../../bloc/schedule_bloc.dart';

// class SuggestedSchedWidget extends StatelessWidget {
//   const SuggestedSchedWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ScheduleBloc, ScheduleState>(
//       builder: (context, state) {
//         if (state is ScheduleLoaded){
//           return BlocBuilder<UploadScheduleBloc, UploadScheduleState>(
//             builder: (context, state) {
//               if (state is ScheduleIsSaving) {

//                 return const Column(
//                   children: [
//                     Text("Saving Schedule"),
//                     // SizedBox(height: 200.0),
//                     Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   ],
//                 );
//               } else {
//                 return const SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           "Here’s your suggested schedule",
//                           style: TextStyle(fontSize: 22),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       AccordionPage(),
//                       SizedBox(
//                         height: 200.0,
//                       ),
//                     ],
//                   ),
//                 );
//               }
//             },
//           );
//         }
//         else{
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       },
//     );
//   }
// }
